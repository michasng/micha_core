import 'dart:async';
import 'dart:math';

import 'package:micha_core/micha_core.dart';

final _logger = createNamedLogger('withRetry');

typedef RetryStrategy = Duration Function(int attemptCount);

/// Returns a function to calculate a delay that exponentially increases with each attempt.
/// The delay starts at [initialDelay] and exponentially doubles until [maxDelay] is reached.
RetryStrategy createExponentialBackoff({
  Duration initialDelay = const Duration(seconds: 1),
  Duration maxDelay = const Duration(seconds: 30),
}) {
  assert(initialDelay <= maxDelay);
  assert(maxDelay > Duration.zero);

  return (attemptCount) =>
      (initialDelay * pow(2, attemptCount - 1)).clamp(initialDelay, maxDelay);
}

/// Retries a given [operation] until it succeeds and forwards the return value.
/// A call is attempted at least once and at most [maxAttemptCount] times.
///
/// The [operation] is retried after throwing an exception of type [TException] or after any exception, if no type is specified.
/// Use [shouldRetry] to further restrict exceptions to retry for.
///
/// Uses exponential backoff by default, but a different [strategy] can be used.
Future<T> retried<T, TException extends Object>(
  FutureOr<T> Function() operation, {
  int? maxAttemptCount = 3,
  RetryStrategy? strategy,
  bool Function(TException exception)? shouldRetry,
  Future<void> Function(Duration duration) waitForDuration =
      Future<void>.delayed,
}) async {
  final nonNullStrategy = strategy ?? createExponentialBackoff();

  int attemptCount = 0;
  while (true) {
    try {
      return await operation();
    } on TException catch (exception) {
      if (shouldRetry != null && !shouldRetry(exception)) {
        rethrow;
      }

      attemptCount++;
      if (maxAttemptCount != null && attemptCount >= maxAttemptCount) {
        _logger.severe('Retry limit reached.', exception, StackTrace.current);
        rethrow;
      }

      var delay = nonNullStrategy(attemptCount);
      if (exception is RetryException) {
        delay = exception.delay ?? delay;
      }

      _logger.finest(
        'A retried operation failed. Waiting for ${delay.inMilliseconds / 1000} seconds.',
        exception,
        StackTrace.current,
      );
      await waitForDuration(delay);
      _logger.finer('Retrying (attempt $attemptCount / $maxAttemptCount).');
    }
  }
}

/// Can be thrown with a custom [delay] that overrides the strategy in [retried].
class RetryException implements Exception {
  final String? message;
  final Duration? delay;

  RetryException(this.message, {this.delay});

  @override
  String toString() {
    const type = RetryException;

    final messageLabel = message?.transform((message) => ': $message');
    final retryAfterLabel = delay?.transform(
      (duration) => ' (retry after ${duration.inSeconds / 1000} seconds)',
    );
    return '$type$messageLabel$retryAfterLabel';
  }
}

import 'dart:async';

/// Limits the execution rate of asynchronous operations.
///
/// This class enforces a minimum time [interval] between consecutive executions
/// of any given operation. This is useful in scenarios where you want
/// to throttle the execution of tasks to avoid overloading a system or API.
///
/// [T] is the return type of the operations to execute.
class RateLimiter<T> {
  final Duration _interval;
  DateTime? _lastExecutionTime;
  Completer<void>? _completer;

  RateLimiter(Duration interval) : _interval = interval;

  /// Executes the given asynchronous operation while enforcing the rate limit.
  ///
  /// If the interval since the last execution has not passed, the method waits
  /// until the interval elapses before executing the operation.
  ///
  /// Pass an asynchronous [operation] to be executed.
  ///
  /// Returns the result of [operation].
  Future<T> execute(
    FutureOr<T> Function() operation, {
    DateTime Function() nowProvider = DateTime.now,
    Future<void> Function(Duration duration) waitForDuration =
        Future<void>.delayed,
  }) async {
    while (_completer != null) {
      await _completer!.future;
    }
    _completer = Completer();

    final beforeAsyncTime = nowProvider();
    final lastExecutionTime = _lastExecutionTime;
    if (lastExecutionTime != null) {
      final elapsedTime = beforeAsyncTime.difference(lastExecutionTime);
      if (elapsedTime < _interval) {
        final waitTime = _interval - elapsedTime;
        await waitForDuration(waitTime);
      }
    }

    final result = await operation();
    _lastExecutionTime = nowProvider();
    _completer?.complete();
    _completer = null;
    return result;
  }
}

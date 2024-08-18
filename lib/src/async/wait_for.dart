import 'dart:async';

/// Repeatedly calls and waits until [condition] returns true.
///
/// Needs to be called with [await] in a function marked as [async].
/// Pass a [timeout] to set a maximum time to wait, after which a [TimeoutException] will be thrown.
/// Pass an interval to set the idle duration between checking [condition].
Future<void> waitFor(
  FutureOr<bool> Function() condition, {
  Duration? timeout,
  Duration interval = const Duration(milliseconds: 200),
  DateTime Function() nowProvider = DateTime.now,
  Future<void> Function(Duration duration) waitForDuration =
      Future<void>.delayed,
}) async {
  final startTime = nowProvider();
  while (true) {
    if (await condition()) return;

    var effectiveInterval = interval;
    if (timeout != null) {
      final passedTime = nowProvider().difference(startTime);
      if (passedTime > timeout) {
        throw TimeoutException(
          'Condition did not pass within specified time.',
        );
      }
      final remainingTime = timeout - passedTime;
      effectiveInterval = remainingTime < interval ? remainingTime : interval;
    }

    await waitForDuration(effectiveInterval);
  }
}

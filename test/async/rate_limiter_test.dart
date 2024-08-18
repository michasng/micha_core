import 'package:flutter_test/flutter_test.dart';
import 'package:micha_core/micha_core.dart';

void main() {
  group('RateLimiter', () {
    const testInterval = Duration(seconds: 1);
    final fakeStartTime = DateTime(2024, 1, 1, 0, 0, 0);

    test('executes immediately on first call', () async {
      final rateLimiter = RateLimiter<int>(testInterval);
      bool waitForDurationCalled = false;

      final result = await rateLimiter.execute(
        () async => 42,
        nowProvider: () => fakeStartTime,
        waitForDuration: (_) async => waitForDurationCalled = true,
      );

      expect(result, 42);
      expect(waitForDurationCalled, false);
    });

    test('waits for interval duration between executions', () async {
      final rateLimiter = RateLimiter<int>(testInterval);
      final operationTimes = <DateTime>[];
      DateTime nowProvider() =>
          fakeStartTime.add(testInterval * operationTimes.length);
      final waitedForDurations = <Duration>[];

      final results = [
        for (int i = 0; i < 3; i++)
          await rateLimiter.execute(
            () async {
              operationTimes.add(nowProvider());
              return i;
            },
            nowProvider: nowProvider,
            waitForDuration: (Duration duration) async {
              waitedForDurations.add(duration);
            },
          ),
      ];

      expect(results, [0, 1, 2]);
      expect(operationTimes, [
        fakeStartTime,
        fakeStartTime.add(testInterval),
        fakeStartTime.add(testInterval).add(testInterval),
      ]);
      expect(waitedForDurations, [testInterval, testInterval]);
    });

    test('does not wait when the interval has already passed', () async {
      final rateLimiter = RateLimiter<int>(testInterval);
      final waitedForDurations = <Duration>[];

      await rateLimiter.execute(
        () async => 42,
        nowProvider: () => fakeStartTime,
        waitForDuration: (Duration duration) async {
          waitedForDurations.add(duration);
        },
      );
      await rateLimiter.execute(
        () async => 42,
        nowProvider: () => fakeStartTime.add(testInterval * 2),
        waitForDuration: (Duration duration) async {
          waitedForDurations.add(duration);
        },
      );

      expect(waitedForDurations, isEmpty);
    });
  });
}

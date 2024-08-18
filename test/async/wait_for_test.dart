import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:micha_core/micha_core.dart';

void main() {
  group('waitFor', () {
    const testInterval = Duration(seconds: 1);
    final fakeStartTime = DateTime(2024, 1, 1, 0, 0, 0);

    test('returns immediately if condition is true initially', () async {
      var conditionCalled = false;

      await waitFor(() async {
        conditionCalled = true;
        return true;
      });

      expect(conditionCalled, isTrue);
    });

    test('keeps checking until condition becomes true', () async {
      const expectedCallCount = 3;
      int conditionCallCount = 0;
      final waitedForDurations = <Duration>[];

      await waitFor(
        () async {
          conditionCallCount++;
          return conditionCallCount == expectedCallCount;
        },
        interval: testInterval,
        waitForDuration: (duration) async {
          waitedForDurations.add(duration);
        },
      );

      expect(conditionCallCount, equals(expectedCallCount));
      expect(waitedForDurations, [testInterval, testInterval]);
    });

    test('throws when condition does not become true within timeout', () async {
      const expectedCallCount = 3;
      int conditionCallCount = 0;
      final waitedForDurations = <Duration>[];

      await expectLater(
        waitFor(
          () async {
            conditionCallCount++;
            return false;
          },
          interval: testInterval,
          timeout: testInterval * (expectedCallCount - 1),
          nowProvider: () =>
              fakeStartTime.add(testInterval * conditionCallCount),
          waitForDuration: (duration) async {
            waitedForDurations.add(duration);
          },
        ),
        throwsA(isA<TimeoutException>()),
      );

      expect(conditionCallCount, equals(expectedCallCount));
      expect(waitedForDurations, [testInterval, Duration.zero]);
    });

    test('does not throw when condition becomes true before timeout', () async {
      const expectedCallCount = 3;
      int conditionCallCount = 0;
      final waitedForDurations = <Duration>[];

      await waitFor(
        () async {
          conditionCallCount++;
          return conditionCallCount == expectedCallCount;
        },
        interval: testInterval,
        timeout: testInterval * expectedCallCount,
        nowProvider: () => fakeStartTime.add(testInterval * conditionCallCount),
        waitForDuration: (duration) async {
          waitedForDurations.add(duration);
        },
      );

      expect(conditionCallCount, equals(expectedCallCount));
      expect(waitedForDurations, [testInterval, testInterval]);
    });
  });
}

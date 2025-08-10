import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:micha_core/micha_core.dart';

void main() {
  initLogging(projectLogLevel: Level.OFF);

  group('createExponentialBackoff', () {
    test('returns correct delays with default values', () {
      final strategy = createExponentialBackoff();
      expect(strategy(1), const Duration(seconds: 1));
      expect(strategy(2), const Duration(seconds: 2));
      expect(strategy(3), const Duration(seconds: 4));
      expect(strategy(4), const Duration(seconds: 8));
      expect(strategy(5), const Duration(seconds: 16));
      expect(strategy(6), const Duration(seconds: 30)); // capped by maxDelay
      expect(strategy(7), const Duration(seconds: 30));
    });

    test('clamps delay to maxDelay', () {
      final strategy = createExponentialBackoff(
        initialDelay: const Duration(milliseconds: 500),
        maxDelay: const Duration(seconds: 5),
      );
      expect(strategy(1), const Duration(milliseconds: 500));
      expect(strategy(2), const Duration(seconds: 1));
      expect(strategy(3), const Duration(seconds: 2));
      expect(strategy(4), const Duration(seconds: 4));
      expect(strategy(5), const Duration(seconds: 5)); // capped by maxDelay
      expect(strategy(6), const Duration(seconds: 5));
    });

    test('asserts that initialDelay is greater than maxDelay', () {
      expect(
        () => createExponentialBackoff(
          initialDelay: const Duration(seconds: 5),
          maxDelay: const Duration(seconds: 1),
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('retried', () {
    const testInitialDelay = Duration(seconds: 1);
    const testMaxDelay = Duration(seconds: 4);

    test(
      'returns immediately if operation succeeds on the first attempt',
      () async {
        int attemptCount = 0;

        final result = await retried<int, RetryException>(() async {
          attemptCount++;
          return 42;
        });

        expect(attemptCount, equals(1));
        expect(result, equals(42));
      },
    );

    test('retries the specified number of times before succeeding', () async {
      const expectedAttemptCount = 3;
      int attemptCount = 0;
      final waitedForDurations = <Duration>[];

      final result = await retried<int, RetryException>(
        () async {
          attemptCount++;
          if (attemptCount < expectedAttemptCount) {
            throw RetryException('Temporary failure');
          }
          return 42;
        },
        waitForDuration: (duration) async {
          waitedForDurations.add(duration);
        },
      );

      expect(attemptCount, equals(expectedAttemptCount));
      expect(result, equals(42));
      expect(waitedForDurations, [testInitialDelay, testInitialDelay * 2]);
    });

    test('throws when the operation fails on the final attempt', () async {
      const expectedAttemptCount = 3;
      int attemptCount = 0;
      final waitedForDurations = <Duration>[];

      await expectLater(
        retried<int, RetryException>(
          () async {
            attemptCount++;
            throw RetryException('Permanent failure');
          },
          maxAttemptCount: expectedAttemptCount,
          waitForDuration: (duration) async {
            waitedForDurations.add(duration);
          },
        ),
        throwsA(isA<RetryException>()),
      );

      expect(attemptCount, equals(expectedAttemptCount));
      expect(waitedForDurations, [testInitialDelay, testInitialDelay * 2]);
    });

    test('does not retry if exception is not of the specified type', () async {
      int attemptCount = 0;

      await expectLater(
        retried<int, RetryException>(() async {
          attemptCount++;
          throw Exception('Unknown failure');
        }, waitForDuration: (_) async {}),
        throwsA(isA<Exception>()),
      );

      expect(attemptCount, equals(1));
    });

    test('respects the shouldRetry callback', () async {
      const expectedAttemptCount = 2;
      int attemptCount = 0;
      final waitedForDurations = <Duration>[];

      await expectLater(
        retried<int, RetryException>(
          () async {
            attemptCount++;
            throw RetryException('Conditional failure');
          },
          shouldRetry: (exception) => attemptCount < expectedAttemptCount,
          waitForDuration: (duration) async {
            waitedForDurations.add(duration);
          },
        ),
        throwsA(isA<RetryException>()),
      );

      expect(attemptCount, equals(expectedAttemptCount));
      expect(waitedForDurations, [testInitialDelay]);
    });

    test('respects the delay specified in the exception', () async {
      const expectedAttemptCount = 3;
      int attemptCount = 0;
      final waitedForDurations = <Duration>[];

      final result = await retried<int, RetryException>(
        () async {
          attemptCount++;
          if (attemptCount < expectedAttemptCount) {
            throw RetryException(
              'Temporary failure',
              delay: Duration(seconds: 10 + attemptCount),
            );
          }
          return 42;
        },
        waitForDuration: (duration) async {
          waitedForDurations.add(duration);
        },
      );

      expect(attemptCount, equals(expectedAttemptCount));
      expect(result, equals(42));
      expect(waitedForDurations, [
        const Duration(seconds: 11),
        const Duration(seconds: 12),
      ]);
    });

    test('uses exponential backoff strategy', () async {
      int attemptCount = 0;
      final waitedForDurations = <Duration>[];

      await expectLater(
        retried<int, RetryException>(
          () async {
            attemptCount++;
            throw RetryException('Backoff failure');
          },
          maxAttemptCount: 4,
          strategy: createExponentialBackoff(
            initialDelay: testInitialDelay,
            maxDelay: testMaxDelay,
          ),
          waitForDuration: (duration) async {
            waitedForDurations.add(duration);
          },
        ),
        throwsA(isA<RetryException>()),
      );

      expect(attemptCount, equals(4));
      expect(waitedForDurations, [
        testInitialDelay,
        testInitialDelay * 2,
        testInitialDelay * 4 < testMaxDelay
            ? testInitialDelay * 4
            : testMaxDelay,
      ]);
    });
  });
}

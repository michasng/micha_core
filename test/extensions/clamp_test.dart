import 'package:flutter_test/flutter_test.dart';
import 'package:micha_core/micha_core.dart'; // this defines the function

void main() {
  group('clamp', () {
    test('returns the original duration when within limits', () {
      const duration = Duration(seconds: 5);
      const lowerLimit = Duration(seconds: 2);
      const upperLimit = Duration(seconds: 10);

      final clampedDuration = duration.clamp(lowerLimit, upperLimit);

      expect(clampedDuration, duration);
    });

    test('returns lower limit when duration is below it', () {
      const duration = Duration(seconds: 1);
      const lowerLimit = Duration(seconds: 2);
      const upperLimit = Duration(seconds: 10);

      final clampedDuration = duration.clamp(lowerLimit, upperLimit);

      expect(clampedDuration, lowerLimit);
    });

    test('returns upper limit when duration is above it', () {
      const duration = Duration(seconds: 15);
      const lowerLimit = Duration(seconds: 2);
      const upperLimit = Duration(seconds: 10);

      final clampedDuration = duration.clamp(lowerLimit, upperLimit);

      expect(clampedDuration, upperLimit);
    });

    test('handles edge case where duration equals lower limit', () {
      const duration = Duration(seconds: 2);
      const lowerLimit = Duration(seconds: 2);
      const upperLimit = Duration(seconds: 10);

      final clampedDuration = duration.clamp(lowerLimit, upperLimit);

      expect(clampedDuration, duration);
    });

    test('handles edge case where duration equals upper limit', () {
      const duration = Duration(seconds: 10);
      const lowerLimit = Duration(seconds: 2);
      const upperLimit = Duration(seconds: 10);

      final clampedDuration = duration.clamp(lowerLimit, upperLimit);

      expect(clampedDuration, duration);
    });

    test('throws when lower limit is greater than upper limit', () {
      const duration = Duration(seconds: 5);
      const lowerLimit = Duration(seconds: 10);
      const upperLimit = Duration(seconds: 2);

      expect(
        () => duration.clamp(lowerLimit, upperLimit),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}

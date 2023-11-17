import 'package:flutter_test/flutter_test.dart';
import 'package:micha_core/micha_core.dart';

void main() {
  group('times', () {
    test('executes an action a given positive number of times', () {
      final timesCalledWith = <int>[];
      1.times((index) => timesCalledWith.add(index));
      expect(timesCalledWith, [0]);

      timesCalledWith.clear();
      5.times((index) => timesCalledWith.add(index));
      expect(timesCalledWith, equals([0, 1, 2, 3, 4]));
    });

    test('does not execute an action 0 times', () {
      bool actionCalled = false;
      0.times((index) => actionCalled = true);
      expect(actionCalled, false);
    });

    test('does not execute an action a negative number of times', () {
      bool actionCalled = false;
      (-1).times((index) => actionCalled = true);
      expect(actionCalled, false);
      (-5).times((index) => actionCalled = true);
      expect(actionCalled, false);
    });
  });
}

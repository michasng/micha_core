import 'package:flutter_test/flutter_test.dart';
import 'package:micha_core/src/extensions/split.dart';

void main() {
  group('splitIndexed', () {
    test('splits a list at specific indexes', () {
      expect(
        [0, 1, 2, 3, 4, 5, 6].splitIndexed((index, _) => index % 3 == 0),
        [
          <int>[],
          [1, 2],
          [4, 5],
          <int>[],
        ],
      );
    });

    for (final (initial: initial, expected: expected) in [
      (
        initial: [0, 1, 2, 0, 4, 5, 0],
        expected: [
          <int>[],
          [1, 2],
          [4, 5],
          <int>[],
        ]
      ),
      (
        initial: [1, 2, 0, 4, 5, 0],
        expected: [
          [1, 2],
          [4, 5],
          <int>[],
        ]
      ),
      (
        initial: [0, 1, 2, 0, 4, 5],
        expected: [
          <int>[],
          [1, 2],
          [4, 5],
        ]
      ),
      (
        initial: [1, 2, 0, 4, 5],
        expected: [
          [1, 2],
          [4, 5],
        ]
      ),
    ]) {
      test('splits a list at specific items', () {
        expect(
          initial.splitIndexed((_, item) => item == 0),
          expected,
        );
      });
    }
  });

  group('split', () {
    test('splits a list at specific items', () {
      expect(
        [0, 1, 2, 0, 4, 5, 0].split((item) => item == 0),
        [
          <int>[],
          [1, 2],
          [4, 5],
          <int>[],
        ],
      );
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:micha_core/micha_core.dart';

void main() {
  group('separatedBy', () {
    test('separates a list by the return value of getSeparator', () {
      int getSeparator(int before, int after) => before + after;
      expect(
        [1, 2, 3].separatedBy(getSeparator),
        [1, 3, 2, 5, 3],
      );
    });

    test('does not separate items for which getSeparator returns null', () {
      int? getSeparator(int before, int after) {
        if (before == 1) return null;
        return before + after;
      }

      expect(
        [1, 2, 3].separatedBy(getSeparator),
        [1, 2, 5, 3],
      );
    });

    test('does not insert separators when given an empty list', () {
      bool getSeparatorCalled = false;
      int getSeparator(_, __) {
        getSeparatorCalled = true;
        return 0;
      }

      final result = <int>[].separatedBy(getSeparator);

      expect(result, <int>[]);
      expect(getSeparatorCalled, false);
    });

    test('does not insert separators when given a list with a single item', () {
      bool getSeparatorCalled = false;
      int getSeparator(_, __) {
        getSeparatorCalled = true;
        return 0;
      }

      final result = [1].separatedBy(getSeparator);

      expect(result, [1]);
      expect(getSeparatorCalled, false);
    });
  });

  group('separated', () {
    test('separates a list by a given separator', () {
      expect([1, 2, 3].separated(0), [1, 0, 2, 0, 3]);
    });

    test('does not insert separators when given an empty list', () {
      expect(<int>[].separated(0), <int>[]);
    });

    test('does not insert separators when given a list with a single item', () {
      expect([1].separated(0), [1]);
    });
  });
}

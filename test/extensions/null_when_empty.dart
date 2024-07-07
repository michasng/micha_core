import 'package:flutter_test/flutter_test.dart';
import 'package:micha_core/micha_core.dart';

void main() {
  group('IterableNullWhenEmpty', () {
    test('returns null when Iterable is empty', () {
      final it = <int>[];

      expect(it.nullWhenEmpty, null);
    });

    test('returns Iterable unchanged when it is not empty', () {
      final it = [1, 2, 3];

      expect(it.nullWhenEmpty, [1, 2, 3]);
    });
  });

  group('MapNullWhenEmpty', () {
    test('returns null when Map is empty', () {
      final it = <String, int>{};

      expect(it.nullWhenEmpty, null);
    });

    test('returns Map unchanged when it is not empty', () {
      final it = {
        'a': 1,
      };

      expect(it.nullWhenEmpty, {
        'a': 1,
      });
    });
  });

  group('StringNullWhenEmpty', () {
    test('returns null when String is empty', () {
      const it = '';

      expect(it.nullWhenEmpty, null);
    });

    test('returns String unchanged when it is not empty', () {
      const it = 'foo';

      expect(it.nullWhenEmpty, 'foo');
    });
  });
}

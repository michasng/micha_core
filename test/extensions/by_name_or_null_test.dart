import 'package:flutter_test/flutter_test.dart';
import 'package:micha_core/extensions/by_name_or_null.dart';

enum TestEnum { one, two, three }

void main() {
  group('byNameOrNull', () {
    test('returns the correct item, when found by name', () {
      final result = TestEnum.values.byNameOrNull('two');

      expect(result, TestEnum.two);
    });

    test('returns null, when no item was found', () {
      final result = TestEnum.values.byNameOrNull('four');

      expect(result, null);
    });
  });
}

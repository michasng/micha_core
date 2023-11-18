import 'package:flutter_test/flutter_test.dart';
import 'package:micha_core/micha_core.dart';

void main() {
  group('wrapped', () {
    for (final value in [1, 'foo', null]) {
      test('adds a Wrapper around values of type ${value.runtimeType}', () {
        final wrapped = value.wrapped;

        expect(wrapped, Wrapper.of(value));
        expect(wrapped.value, value);
      });
    }
  });
}

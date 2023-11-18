import 'package:flutter/foundation.dart';

@immutable
class Wrapper<T> {
  final T value;
  const Wrapper.of(this.value);

  @override
  bool operator ==(Object other) =>
      other is Wrapper &&
      other.runtimeType == runtimeType &&
      other.value == value;

  @override
  int get hashCode => value.hashCode;
}

extension Wrapped<T> on T {
  Wrapper<T> get wrapped => Wrapper.of(this);
}

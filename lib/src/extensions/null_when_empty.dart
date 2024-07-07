extension IterableNullWhenEmpty<TItem, TIterable extends Iterable<TItem>>
    on TIterable {
  /// Returns null when this is empty.
  /// Returns this when not empty.
  TIterable? get nullWhenEmpty {
    if (isEmpty) return null;
    return this;
  }
}

extension MapNullWhenEmpty<TKey, TValue, TMap extends Map<TKey, TValue>>
    on TMap {
  /// Returns null when this is empty.
  /// Returns this when not empty.
  TMap? get nullWhenEmpty {
    if (isEmpty) return null;
    return this;
  }
}

extension StringNullWhenEmpty on String {
  /// Returns null when this is empty.
  /// Returns this when not empty.
  String? get nullWhenEmpty {
    if (isEmpty) return null;
    return this;
  }
}

extension IterableSeparated<T> on Iterable<T> {
  /// Concatenates items by the result of a callback.
  ///
  /// Iterates through items and yields the results of calls to [getSeparator] in-between the original items.
  /// [getSeparator] is called with pairs of precending and succeeding items and returns their desired separator.
  /// [getSeparator] may return null to insert no separator at that position.
  Iterable<T> separatedBy(T? Function(T before, T after) getSeparator) sync* {
    Iterator<T> iterator = this.iterator;
    if (!iterator.moveNext()) return;

    T previousItem;
    yield previousItem = iterator.current;
    while (iterator.moveNext()) {
      final separator = getSeparator(previousItem, iterator.current);
      if (separator != null) yield separator;
      yield previousItem = iterator.current;
    }
  }

  /// Concatenates items by a constant separator.
  Iterable<T> separated(T separator) {
    return separatedBy((_, _) => separator);
  }
}

/// Functions are identical to those of [IterableSeparated].
/// Results are converted to lists, so the original list is not modified.
extension ListSeparated<T> on List<T> {
  /// Concatenates items by the result of a callback. Cmp. [IterableSeparated.separated].
  List<T> separated(T separator) {
    return IterableSeparated(this).separated(separator).toList();
  }

  /// Concatenates items by a constant separator. Cmp. [IterableSeparated.separatedBy].
  List<T> separatedBy(T? Function(T before, T after) getSeparator) {
    return IterableSeparated(this).separatedBy(getSeparator).toList();
  }
}

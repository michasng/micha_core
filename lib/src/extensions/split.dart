extension IterableSplit<T> on Iterable<T> {
  /// Splits an iterable at every item for which [isSeparator] returns `true`.
  ///
  /// [isSeparator] is called once for every item.
  /// The separators themselves are not included in the result.
  /// The number of results is equal to the number of separators + 1.
  Iterable<List<T>> splitIndexed(
    bool Function(int index, T item) isSeparator,
  ) sync* {
    var chunk = <T>[];

    for (final (index, item) in indexed) {
      if (isSeparator(index, item)) {
        yield chunk;
        chunk = [];
        continue;
      }
      chunk.add(item);
    }

    yield chunk;
  }

  /// Splits an iterable at every item for which [isSeparator] returns `true`. Cmp. [splitIndexed].
  Iterable<List<T>> split(bool Function(T item) isSeparator) {
    return splitIndexed((_, item) => isSeparator(item));
  }
}

/// Functions are identical to those of [IterableSplit].
/// Results are converted to lists, so the original list is not modified.
extension ListSplit<T> on List<T> {
  /// Splits an iterable at every item for which [isSeparator] returns `true`. Cmp. [IterableSplit.splitIndexed].
  List<List<T>> splitIndexed(bool Function(int index, T item) isSeparator) {
    return IterableSplit(this).splitIndexed(isSeparator).toList();
  }

  /// Splits an iterable at every item for which [isSeparator] returns `true`. Cmp. [IterableSplit.split].
  List<List<T>> split(bool Function(T item) isSeparator) {
    return IterableSplit(this).split(isSeparator).toList();
  }
}

extension GetOrPut<TKey, TValue> on Map<TKey, TValue> {
  /// Access this [Map] by [key] and always get a value.
  ///
  /// Calls [createDefault] when this [Map] does not contain the [key],
  /// adds the value returned by [createDefault] to this [Map] and returns it.
  TValue getOrPut(TKey key, TValue Function() createDefault) {
    final value = this[key];
    if (value != null) return value;

    final defaultValue = createDefault();
    this[key] = defaultValue;
    return defaultValue;
  }
}

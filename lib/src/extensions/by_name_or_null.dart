extension ByNameOrNull<T extends Enum> on Iterable<T> {
  /// Finds the enum value in this collection with name [name] or `null`.
  ///
  /// Goes through this collection looking for an enum with name [name], as reported by [EnumName.name].
  /// Returns the first value with the given name. Returns `null`, if no value is found.
  T? byNameOrNull(String name) {
    try {
      return byName(name);
    } on ArgumentError catch (_) {
      return null;
    }
  }
}

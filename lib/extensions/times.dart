typedef TimesCallback<T> = T Function(int index);

extension Times on int {
  Iterable<T> generateTimes<T>(TimesCallback<T> action) sync* {
    for (int index = 0; index < this; index++) {
      yield action(index);
    }
  }

  /// Executes a given callback, as many times as the value of this [int].
  /// The return values of the callbacks are collected and returned as a list.
  List<T> times<T>(TimesCallback<T> action) {
    return generateTimes(action).toList();
  }
}

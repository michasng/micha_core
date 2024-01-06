extension Transform<TOrigin> on TOrigin {
  /// Passes this to [fn] and returns the result.
  TTarget transform<TTarget>(TTarget Function(TOrigin) fn) {
    return fn(this);
  }
}

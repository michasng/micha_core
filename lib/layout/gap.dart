import 'package:flutter/material.dart';

/// Adds a fixed space between children of e.g. a [Column] or [Row].
/// If a more or less space is desired,
/// use the overloaded multiplication or division operators respectively.
class Gap extends StatelessWidget {
  static const double defaultGapSize = 16;

  final double size;

  const Gap({
    super.key,
    this.size = defaultGapSize,
  });

  Gap operator *(double factor) {
    return Gap(size: size * factor);
  }

  Gap operator /(double divisor) {
    return Gap(size: size / divisor);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
    );
  }
}

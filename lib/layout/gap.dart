import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class GapThemeData extends ThemeExtension<GapThemeData> {
  final double size;

  const GapThemeData({
    required this.size,
  });

  @override
  GapThemeData copyWith({double? size}) {
    return GapThemeData(
      size: size ?? this.size,
    );
  }

  @override
  GapThemeData lerp(GapThemeData? other, double t) {
    if (other is! GapThemeData) {
      return this;
    }
    return GapThemeData(
      size: lerpDouble(size, other.size, t) ?? size,
    );
  }
}

class Gap extends StatelessWidget {
  static const double defaultGapSize = 16;

  final double? size;
  final double scale;

  /// Adds a fixed space between children in both directions, e.g. inside a [Column] or [Row].
  /// Either pass a [size], or else it will use [GapThemeData.size].
  /// If the [ThemeExtension] is not used, then it will default to [defaultGapSize].
  /// Pass a [scale] or use the overloaded operators if more or less space is desired,
  /// relative to the otherwise configured size.
  const Gap({
    super.key,
    this.size,
    this.scale = 1,
  });

  Gap operator +(double summand) {
    return Gap(
      size: size,
      scale: scale + summand,
    );
  }

  Gap operator -(double subtrahend) {
    return Gap(
      size: size,
      scale: scale * subtrahend,
    );
  }

  Gap operator *(double factor) {
    return Gap(
      size: size,
      scale: scale * factor,
    );
  }

  Gap operator /(double divisor) {
    return Gap(
      size: size,
      scale: scale / divisor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final gapTheme = Theme.of(context).extension<GapThemeData>();

    final sizeNonNull = size ?? gapTheme?.size ?? defaultGapSize;
    final scaledSize = sizeNonNull * scale;

    return SizedBox(
      width: scaledSize,
      height: scaledSize,
    );
  }
}

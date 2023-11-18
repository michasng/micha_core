import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:micha_core/src/extensions/wrapped.dart';

@immutable
class SpinnerThemeData extends ThemeExtension<SpinnerThemeData> {
  final double? size;
  final double? strokeWidth;

  const SpinnerThemeData({
    this.size,
    this.strokeWidth,
  })  : assert(size == null || size > 0, 'size must be positive or null.'),
        assert(strokeWidth == null || strokeWidth > 0,
            'strokeWidth must be positive or null.');

  @override
  SpinnerThemeData copyWith({
    Wrapper<double?>? size,
    Wrapper<double?>? strokeWidth,
  }) {
    return SpinnerThemeData(
      size: size == null ? this.size : size.value,
      strokeWidth: strokeWidth == null ? this.strokeWidth : strokeWidth.value,
    );
  }

  @override
  SpinnerThemeData lerp(SpinnerThemeData? other, double t) {
    if (other is! SpinnerThemeData) {
      return this;
    }
    return SpinnerThemeData(
      size: lerpDouble(size, other.size, t) ?? size,
      strokeWidth: lerpDouble(strokeWidth, other.strokeWidth, t) ?? strokeWidth,
    );
  }
}

class Spinner extends StatelessWidget {
  static const double defaultStrokeWidth = 2;

  final double? size;
  final double? strokeWidth;

  const Spinner({
    super.key,
    this.size,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    final spinnerTheme = Theme.of(context).extension<SpinnerThemeData>();

    return Center(
      child: SizedBox(
        width: size ?? spinnerTheme?.size,
        height: size ?? spinnerTheme?.size,
        child: CircularProgressIndicator(
          strokeWidth:
              strokeWidth ?? spinnerTheme?.strokeWidth ?? defaultStrokeWidth,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:micha_core/src/extensions/wrapped.dart';

@immutable
class LinkThemeData extends ThemeExtension<LinkThemeData> {
  final Color? color;
  final bool? underlined;

  const LinkThemeData({
    required this.color,
    required this.underlined,
  });

  @override
  LinkThemeData copyWith({
    Wrapper<Color?>? color,
    Wrapper<bool?>? underlined,
  }) {
    return LinkThemeData(
      color: color == null ? this.color : color.value,
      underlined: underlined == null ? this.underlined : underlined.value,
    );
  }

  @override
  LinkThemeData lerp(LinkThemeData? other, double t) {
    if (other is! LinkThemeData) {
      return this;
    }
    return LinkThemeData(
      color: Color.lerp(color, other.color, t),
      underlined: t < 0.5 ? underlined : other.underlined,
    );
  }
}

class Link extends StatelessWidget {
  static const defaultColor = Color(0xff0000ee);
  static const defaultUnderlined = true;

  final Widget child;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final Color? color;
  final bool? underlined;

  const Link({
    super.key,
    required this.child,
    this.onTap,
    this.focusNode,
    this.color,
    this.underlined,
  });

  @override
  Widget build(BuildContext context) {
    final linkTheme = Theme.of(context).extension<LinkThemeData>();
    final nonNullColor = color ?? linkTheme?.color ?? defaultColor;
    final nonNullUnderlined =
        underlined ?? linkTheme?.underlined ?? defaultUnderlined;

    final outerDefaultTextStyle = DefaultTextStyle.of(context);

    if (onTap == null) return child;

    return InkWell(
      onTap: onTap,
      focusNode: focusNode,
      child: DefaultTextStyle(
        style: outerDefaultTextStyle.style.copyWith(
          color: nonNullColor,
          decoration: nonNullUnderlined ? TextDecoration.underline : null,
          decorationColor: nonNullColor,
        ),
        child: child,
      ),
    );
  }
}

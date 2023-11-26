import 'package:flutter/material.dart';
import 'package:micha_core/src/extensions/wrapped.dart';

@immutable
class PaginationThemeData extends ThemeExtension<PaginationThemeData> {
  final TextStyle? currentPageLabelStyle;
  final TextStyle? jumpToNumberedPageStyle;
  final Widget? fillerControl;
  final Widget? jumpToPreviousPageIcon;
  final Widget? jumpToNextPageIcon;

  const PaginationThemeData({
    this.currentPageLabelStyle,
    this.jumpToNumberedPageStyle,
    this.fillerControl,
    this.jumpToPreviousPageIcon,
    this.jumpToNextPageIcon,
  });

  @override
  PaginationThemeData copyWith({
    Wrapper<TextStyle?>? currentPageLabelStyle,
    Wrapper<TextStyle?>? jumpToNumberedPageStyle,
    Wrapper<Widget?>? jumpToPreviousPageIcon,
    Wrapper<Widget?>? jumpToNextPageIcon,
  }) {
    return PaginationThemeData(
      currentPageLabelStyle: currentPageLabelStyle == null
          ? this.currentPageLabelStyle
          : currentPageLabelStyle.value,
      jumpToNumberedPageStyle: jumpToNumberedPageStyle == null
          ? this.jumpToNumberedPageStyle
          : jumpToNumberedPageStyle.value,
      jumpToPreviousPageIcon: jumpToPreviousPageIcon == null
          ? this.jumpToPreviousPageIcon
          : jumpToPreviousPageIcon.value,
      jumpToNextPageIcon: jumpToNextPageIcon == null
          ? this.jumpToNextPageIcon
          : jumpToNextPageIcon.value,
    );
  }

  @override
  PaginationThemeData lerp(PaginationThemeData? other, double t) {
    if (other is! PaginationThemeData) {
      return this;
    }
    return PaginationThemeData(
      currentPageLabelStyle:
          TextStyle.lerp(currentPageLabelStyle, other.currentPageLabelStyle, t),
      jumpToNumberedPageStyle: TextStyle.lerp(
        jumpToNumberedPageStyle,
        other.jumpToNumberedPageStyle,
        t,
      ),
      jumpToPreviousPageIcon:
          t < 0.5 ? jumpToPreviousPageIcon : other.jumpToPreviousPageIcon,
    );
  }
}

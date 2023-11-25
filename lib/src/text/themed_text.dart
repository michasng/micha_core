import 'package:flutter/material.dart';

class TextOptions {
  final Key? key;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  const TextOptions({
    this.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });
}

/// Avoid accessing ThemeData to apply styles.
/// Call one of the factory constructors of StyledText instad.
class ThemedText extends StatelessWidget {
  final String data;
  final TextStyle? Function(ThemeData theme) getTextStyle;
  final TextOptions? options;

  const ThemedText._internal(
    this.data, {
    super.key,
    required this.getTextStyle,
    this.options,
  });

  factory ThemedText.displayLarge(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.displayLarge,
        options: options,
      );

  factory ThemedText.displayMedium(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.displayMedium,
        options: options,
      );

  factory ThemedText.displaySmall(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.displaySmall,
        options: options,
      );

  factory ThemedText.headlineLarge(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.headlineLarge,
        options: options,
      );

  factory ThemedText.headlineMedium(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.headlineMedium,
        options: options,
      );

  factory ThemedText.headlineSmall(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.headlineSmall,
        options: options,
      );

  factory ThemedText.titleLarge(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.titleLarge,
        options: options,
      );

  factory ThemedText.titleMedium(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.titleMedium,
        options: options,
      );

  factory ThemedText.titleSmall(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.titleSmall,
        options: options,
      );

  factory ThemedText.bodyLarge(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.bodyLarge,
        options: options,
      );

  factory ThemedText.bodyMedium(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.bodyMedium,
        options: options,
      );

  factory ThemedText.bodySmall(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.bodySmall,
        options: options,
      );

  factory ThemedText.labelLarge(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.labelLarge,
        options: options,
      );

  factory ThemedText.labelMedium(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.labelMedium,
        options: options,
      );

  factory ThemedText.labelSmall(
    String data, {
    Key? key,
    TextOptions? options,
  }) =>
      ThemedText._internal(
        data,
        key: key,
        getTextStyle: (theme) => theme.textTheme.labelSmall,
        options: options,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = getTextStyle(theme);

    final text = Text(
      data,
      key: options?.key,
      style: options?.style,
      strutStyle: options?.strutStyle,
      textAlign: options?.textAlign,
      textDirection: options?.textDirection,
      locale: options?.locale,
      softWrap: options?.softWrap,
      overflow: options?.overflow,
      textScaler: options?.textScaler,
      maxLines: options?.maxLines,
      semanticsLabel: options?.semanticsLabel,
      textWidthBasis: options?.textWidthBasis,
      textHeightBehavior: options?.textHeightBehavior,
      selectionColor: options?.selectionColor,
    );

    if (style == null) return text;
    return DefaultTextStyle(
      style: style,
      child: text,
    );
  }
}

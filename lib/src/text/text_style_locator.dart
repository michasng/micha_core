import 'package:flutter/material.dart';

abstract interface class TextStyleLocator {
  TextStyle? locate(ThemeData theme);
}

class DisplayLargeLocator implements TextStyleLocator {
  const DisplayLargeLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.displayLarge;
}

class DisplayMediumLocator implements TextStyleLocator {
  const DisplayMediumLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.displayMedium;
}

class DisplaySmallLocator implements TextStyleLocator {
  const DisplaySmallLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.displaySmall;
}

class HeadlineLargeLocator implements TextStyleLocator {
  const HeadlineLargeLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.headlineLarge;
}

class HeadlineMediumLocator implements TextStyleLocator {
  const HeadlineMediumLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.headlineMedium;
}

class HeadlineSmallLocator implements TextStyleLocator {
  const HeadlineSmallLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.headlineSmall;
}

class TitleLargeLocator implements TextStyleLocator {
  const TitleLargeLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.titleLarge;
}

class TitleMediumLocator implements TextStyleLocator {
  const TitleMediumLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.titleMedium;
}

class TitleSmallLocator implements TextStyleLocator {
  const TitleSmallLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.titleSmall;
}

class BodyLargeLocator implements TextStyleLocator {
  const BodyLargeLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.bodyLarge;
}

class BodyMediumLocator implements TextStyleLocator {
  const BodyMediumLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.bodyMedium;
}

class BodySmallLocator implements TextStyleLocator {
  const BodySmallLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.bodySmall;
}

class LabelLargeLocator implements TextStyleLocator {
  const LabelLargeLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.labelLarge;
}

class LabelMediumLocator implements TextStyleLocator {
  const LabelMediumLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.labelMedium;
}

class LabelSmallLocator implements TextStyleLocator {
  const LabelSmallLocator();

  @override
  TextStyle? locate(ThemeData theme) => theme.textTheme.labelSmall;
}

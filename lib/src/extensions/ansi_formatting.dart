/// ANSI escape character, indicating the beginning of an ANSI escape sequence
const ansiEscape = '\x1B';

// CSI
const controlSequenceIntroducer = '$ansiEscape[';

/// Select Graphic Rendition, applied in format: `CSI n m`
enum SgrCode {
  reset(0),
  bold(1),
  dim(2),
  italic(3),
  underlined(4),
  inverted(7),
  hidden(8),
  struckThrough(9),
  normalIntensity(22),
  notItalic(23),
  notUnderlined(24),
  notInverted(27),
  notHidden(28),
  notStruckThrough(29),
  black(30),
  red(31),
  green(32),
  yellow(33),
  blue(34),
  magenta(35),
  cyan(36),
  white(37),
  defaultColor(39),
  bgBlack(40),
  bgRed(41),
  bgGreen(42),
  bgYellow(43),
  bgBlue(44),
  bgMagenta(45),
  bgCyan(46),
  bgWhite(47),
  defaultBgColor(49),
  overlined(53),
  notOverlined(55);

  final int n;
  const SgrCode(this.n);

  @override
  String toString() => '$controlSequenceIntroducer${n}m';
}

/// String formatting methods using ANSI escape sequences.
/// Primarily useful for logging to consoles.
/// Bright colors are not included,
/// because they are not supported by all terminals.
extension AnsiFormatting on String {
  /// get with an SGR code applied
  String style(SgrCode code) => '$code$this';

  /// Get with an SGR code applied and an additional code to reset at the end.
  /// Resetting may only be noticable when appending strings,
  String styleThenReset(SgrCode code, SgrCode resetCode) => '$code$this$resetCode';

  /// get with any prior styles reset
  String get resetAll => style(SgrCode.reset);

  /// get with bold style, also resets dim style
  String get bold => styleThenReset(SgrCode.bold, SgrCode.normalIntensity);

  /// get with dim style, also resets bold style
  String get dim => styleThenReset(SgrCode.dim, SgrCode.normalIntensity);

  /// get with italic style
  String get italic => styleThenReset(SgrCode.italic, SgrCode.notItalic);

  /// get with underlined style
  String get underlined =>
      styleThenReset(SgrCode.underlined, SgrCode.notUnderlined);

  /// get with underlined style
  String get overlined =>
      styleThenReset(SgrCode.overlined, SgrCode.notOverlined);

  /// get with hidden style
  String get hidden => styleThenReset(SgrCode.hidden, SgrCode.notHidden);

  /// get with struck through style
  String get struckThrough =>
      styleThenReset(SgrCode.struckThrough, SgrCode.notStruckThrough);

  /// get with inverted colors (foreground and background color swapped)
  String get inverted => styleThenReset(SgrCode.inverted, SgrCode.notInverted);

  /// get with black foreground color, also resets other foreground color
  String get black => styleThenReset(SgrCode.black, SgrCode.defaultColor);

  /// get with red foreground color, also resets other foreground color
  String get red => styleThenReset(SgrCode.red, SgrCode.defaultColor);

  /// get with green foreground color, also resets other foreground color
  String get green => styleThenReset(SgrCode.green, SgrCode.defaultColor);

  /// get with yellow foreground color, also resets other foreground color
  String get yellow => styleThenReset(SgrCode.yellow, SgrCode.defaultColor);

  /// get with blue foreground color, also resets other foreground color
  String get blue => styleThenReset(SgrCode.blue, SgrCode.defaultColor);

  /// get with magenta foreground color, also resets other foreground color
  String get magenta => styleThenReset(SgrCode.magenta, SgrCode.defaultColor);

  /// get with cyan foreground color, also resets other foreground color
  String get cyan => styleThenReset(SgrCode.cyan, SgrCode.defaultColor);

  /// get with white foreground color, also resets other foreground color
  String get white => styleThenReset(SgrCode.white, SgrCode.defaultColor);

  /// get with black background color, also resets other background color
  String get bgBlack => styleThenReset(SgrCode.bgBlack, SgrCode.defaultBgColor);

  /// get with red background color, also resets other background color
  String get bgRed => styleThenReset(SgrCode.bgRed, SgrCode.defaultBgColor);

  /// get with green background color, also resets other background color
  String get bgGreen => styleThenReset(SgrCode.bgGreen, SgrCode.defaultBgColor);

  /// get with yellow background color, also resets other background color
  String get bgYellow =>
      styleThenReset(SgrCode.bgYellow, SgrCode.defaultBgColor);

  /// get with blue background color, also resets other background color
  String get bgBlue => styleThenReset(SgrCode.bgBlue, SgrCode.defaultBgColor);

  /// get with magenta background color, also resets other background color
  String get bgMagenta =>
      styleThenReset(SgrCode.bgMagenta, SgrCode.defaultBgColor);

  /// get with cyan background color, also resets other background color
  String get bgCyan => styleThenReset(SgrCode.bgCyan, SgrCode.defaultBgColor);

  /// get with white background color, also resets other background color
  String get bgWhite => styleThenReset(SgrCode.bgWhite, SgrCode.defaultBgColor);
}

String _ansiEscape = '\x1B';
String _controlSequenceIntroducer = '$_ansiEscape['; // CSI

/// String formatting methods using ANSI escape sequences.
/// Primarily useful for logging to consoles.
/// Bright colors are not included,
/// because they are not supported by all terminals.
extension AnsiFormatting on String {
  /// Select Graphic Rendition (SGR, format: `CSI n m`)
  String _controlSequenceCode(int code) =>
      '$_controlSequenceIntroducer${code}m';
  String _controlSequence(int startCode, int endCode) =>
      '${_controlSequenceCode(startCode)}$this${_controlSequenceCode(endCode)}';

  /// get with any prior styles reset
  String get reset => '${_controlSequenceCode(0)}$this';

  /// get with bold style
  String get bold => _controlSequence(1, 22);

  /// get with dim style
  String get dim => _controlSequence(2, 22);

  /// get with italic style
  String get italic => _controlSequence(3, 23);

  /// get with underline style
  String get underline => _controlSequence(4, 24);

  /// get with underline style
  String get overline => _controlSequence(53, 55);

  /// get with inverse style
  String get inverse => _controlSequence(7, 27);

  /// get with hidden style
  String get hidden => _controlSequence(8, 28);

  /// get with strike through style
  String get strikeThrough => _controlSequence(9, 29);

  /// get with black color
  String get black => _controlSequence(30, 39);

  /// get with red color
  String get red => _controlSequence(31, 39);

  /// get with green color
  String get green => _controlSequence(32, 39);

  /// get with yellow color
  String get yellow => _controlSequence(33, 39);

  /// get with blue color
  String get blue => _controlSequence(34, 39);

  /// get with magenta color
  String get magenta => _controlSequence(35, 39);

  /// get with cyan color
  String get cyan => _controlSequence(36, 39);

  /// get with white color
  String get white => _controlSequence(37, 39);

  /// get with black background color
  String get bgBlack => _controlSequence(40, 49);

  /// get with red background color
  String get bgRed => _controlSequence(41, 49);

  /// get with green background color
  String get bgGreen => _controlSequence(42, 49);

  /// get with yellow background color
  String get bgYellow => _controlSequence(43, 49);

  /// get with blue background color
  String get bgBlue => _controlSequence(44, 49);

  /// get with magenta background color
  String get bgMagenta => _controlSequence(45, 49);

  /// get with cyan background color
  String get bgCyan => _controlSequence(46, 49);

  /// get with white background color
  String get bgWhite => _controlSequence(47, 49);
}

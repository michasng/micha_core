import 'package:logging/logging.dart';
import 'package:micha_core/src/extensions/ansi_formatting.dart';

Level? _projectLogLevel;

/// Initialize logging.
/// Should be called before [runApp], if logging is used.
void initLogging({
  Level projectLogLevel = Level.ALL,
  Level dependenciesLogLevel = Level.WARNING,
}) {
  _projectLogLevel = projectLogLevel;

  Logger.root.level = dependenciesLogLevel;
  hierarchicalLoggingEnabled = true;

  Logger.root.onRecord.listen((record) {
    final message = _formatLogRecord(record);
    final formattedMessage = _formatByLevel(message, record.level);

    // ignore: avoid_print
    print(formattedMessage);
  });
}

String _formatByLevel(String message, Level level) {
  return switch (level) {
    Level.FINEST => message.green,
    Level.FINER => message.cyan,
    Level.FINE => message.blue,
    Level.CONFIG => message.magenta,
    Level.INFO => message,
    Level.WARNING => message.yellow,
    Level.SEVERE => message.red,
    Level.SHOUT => message.bgRed.bold,
    _ => message,
  };
}

String _formatLogRecord(LogRecord record) {
  final level = record.level.name.padRight(7, ' ');
  final isoTime = record.time.toIso8601String();

  return '$level $isoTime ${record.loggerName}: ${record.message}';
}

/// Recommended way to create a new [Logger] for a given type.
Logger createLogger(Type t) {
  return createNamedLogger(t.toString());
}

/// Create a new [Logger] for a given name.
/// Not recommended. Use [createLogger] instead, if possible.
Logger createNamedLogger(String name) {
  final logger = Logger(name);
  logger.level = _projectLogLevel;
  return logger;
}

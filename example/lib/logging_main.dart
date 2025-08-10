import 'package:flutter/material.dart';
import 'package:micha_core/micha_core.dart';

void main() {
  initLogging();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Logging Example', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  static final logger = createLogger(HomePage);

  const HomePage({super.key});

  void _log() {
    final messages = [
      'bold'.bold,
      'dim'.dim,
      'italic'.italic,
      'underlined'.underlined,
      'overlined'.overlined,
      'inverted'.inverted,
      'hidden'.hidden,
      'struckThrough'.struckThrough,
      'black'.black,
      'red'.red,
      'green'.green,
      'yellow'.yellow,
      'blue'.blue,
      'magenta'.magenta,
      'cyan'.cyan,
      'white'.white,
      'bgBlack'.bgBlack,
      'bgRed'.bgRed,
      'bgGreen'.bgGreen,
      'bgYellow'.bgYellow,
      'bgBlue'.bgBlue,
      'bgMagenta'.bgMagenta,
      'bgCyan'.bgCyan,
      'bgWhite'.bgWhite,
    ];

    for (final message in messages) {
      logger.info('$message - then implicitly reset');
    }

    final chainedStyles = 'chained styles'.bold.italic.underlined.yellow;
    logger.info('$chainedStyles - then implictly reset all');

    final chainedSgrCodes = 'chained SGR codes'
        .style(SgrCode.bold)
        .style(SgrCode.italic)
        .style(SgrCode.underlined)
        .style(SgrCode.yellow);
    // not using string interpolation,
    // because resetAll on the entire string would first reset,
    // then apply the chained styles
    logger.info(chainedSgrCodes + ' - then explicitly reset all'.resetAll);

    logger.finest('finest');
    logger.finer('finer');
    logger.fine('fine');
    logger.info('info');
    logger.config('config');
    logger.warning('warning');
    logger.severe(
      'severe',
      Exception('This is just an example.'),
      StackTrace.current,
    );
    logger.shout('shout');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: _log,
          child: const Text('Log to console'),
        ),
      ),
    );
  }
}

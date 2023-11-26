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
    return const MaterialApp(
      title: 'Logging Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  static final logger = createLogger(HomePage);

  const HomePage({super.key});

  void _log() {
    final messages = [
      'reset'.reset,
      'bold'.bold,
      'dim'.dim,
      'italic'.italic,
      'underline'.underline,
      'overline'.overline,
      'inverse'.inverse,
      'hidden'.hidden,
      'strikeThrough'.strikeThrough,
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
      logger.info(message);
    }

    logger.finest('finest');
    logger.finer('finer');
    logger.fine('fine');
    logger.info('info');
    logger.config('config');
    logger.warning('warning');
    logger.severe('severe');
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

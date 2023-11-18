import 'package:flutter/material.dart';
import 'package:micha_core/micha_core.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Async Example',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _reloadCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AsyncBuilder(
            // only reloads when the key changes
            key: ValueKey(_reloadCount),
            createFuture: () => Future.delayed(
              const Duration(seconds: 1),
              () => 'some data',
            ),
            builder: (context, data) => Text(data),
            // Using custom loading indicator to avoid jittering from size changes.
            // You can also customize the look during error and no-data states.
            loading: const Spinner(size: 2),
          ),
          const Gap(),
          ElevatedButton(
            onPressed: () => setState(() {
              _reloadCount++;
            }),
            child: const Text('Reload'),
          ),
        ],
      ),
    ));
  }
}

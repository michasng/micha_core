import 'package:flutter/material.dart';
import 'package:micha_core/micha_core.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Link Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Link(
                onTap: () => {},
                child: const Text('Default themed'),
              ),
              const Link(
                child: Text('Disabled (no onTap)'),
              ),
              Theme(
                data: ThemeData(
                  extensions: const [
                    LinkThemeData(
                      color: Colors.green,
                      underlined: false,
                    ),
                  ],
                ),
                child: Link(
                  onTap: () => {},
                  child: const Text('Customized with theme extension'),
                ),
              ),
              Link(
                color: Colors.red,
                underlined: false,
                onTap: () => {},
                child: const Text('Customized with constructor parameters'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

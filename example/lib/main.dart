import 'package:flutter/material.dart';
import 'package:micha_core/micha_core.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Micha Core Example',
      theme: ThemeData(
        extensions: const [
          // use theme extensions to customize default values
          SpinnerThemeData(size: 32),
        ],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const itemCount = 10;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children:
                itemCount // generate a list of a given length
                    .times<Widget>(
                      // use themed Text without referencing BuildContext explicitly
                      (index) => ThemedText.headlineMedium('item $index'),
                    )
                    // add a Gap in-between the Text widgets, use math operators to modify the scale.
                    .separated(const Gap() + 2),
          ),
        ),
      ),
    );
  }
}

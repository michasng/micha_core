import 'package:flutter/material.dart';
import 'package:micha_core/micha_core.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagination Example',
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
  static const maxPageSize = 20;

  final _controller = PaginationController();

  Future<Paginated<String>> _getPage(int pageIndex) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Paginated(
      totalItemCount: 200,
      items: maxPageSize
          .times((index) => 'item ${(pageIndex * maxPageSize) + index + 1}'),
    );
  }

  Widget _buildExternalControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          label: const Text('reset (to first page)'),
          onPressed: () => _controller.reset(),
          icon: const Icon(Icons.first_page),
        ),
        TextButton.icon(
          label: const Text('reload (current page)'),
          onPressed: () => _controller.reload(),
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildExternalControls(),
            Flexible(
              child: Pagination(
                controller: _controller,
                maxPageSize: maxPageSize,
                getPage: _getPage,
                builder: (context, items) => ListView(
                  children: [
                    for (final item in items)
                      ListTile(
                        title: Text(item),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

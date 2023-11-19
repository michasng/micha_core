import 'package:flutter/material.dart';
import 'package:micha_core/src/async/async_builder.dart';
import 'package:micha_core/src/layout/gap.dart';
import 'package:micha_core/src/pagination/paginated.dart';
import 'package:micha_core/src/pagination/pagination_controls.dart';

class PaginationController<T> {
  final _key = GlobalKey<_PaginationState<T>>();

  int? get skip => _key.currentState?._currentPageIndex;

  void reset() {
    _key.currentState?._reset();
  }

  void reload() {
    _key.currentState?._reload();
  }

  void jumpToPage(int pageIndex) {
    _key.currentState?._jumpToPage(pageIndex);
  }
}

class Pagination<T> extends StatefulWidget {
  final int maxPageSize;
  final Future<Paginated<T>> Function(int pageIndex) getPage;
  final BuilderCallback<List<T>> builder;
  final int initialPageIndex;
  final bool showControls;

  Pagination({
    required this.maxPageSize,
    required this.getPage,
    required this.builder,
    this.initialPageIndex = 0,
    this.showControls = true,
    PaginationController<T>? controller,
  }) : super(key: controller?._key);

  @override
  State<Pagination<T>> createState() => _PaginationState<T>();
}

class _PaginationState<T> extends State<Pagination<T>> {
  int _rebuildCount = 0;
  int? _totalCount;
  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = widget.initialPageIndex;
  }

  void _reset() {
    setState(() {
      _currentPageIndex = widget.initialPageIndex;
      _rebuildCount++;
    });
  }

  void _reload() {
    setState(() {
      _rebuildCount++;
    });
  }

  void _jumpToPage(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
      _rebuildCount++;
    });
  }

  Future<Paginated<T>> _load() async {
    final paginated = await widget.getPage(_currentPageIndex);

    setState(() {
      _totalCount = paginated.totalItemCount;
    });

    return paginated;
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder(
      key: ValueKey(_rebuildCount),
      createFuture: (context) => _load(),
      builder: (context, paginated) => Column(
        children: [
          Flexible(
            child: widget.builder(context, paginated.items),
          ),
          if (widget.showControls && paginated.totalItemCount > 1) ...[
            const Gap(),
            PaginationControls(
              currentPageIndex: _currentPageIndex,
              pageCount: (_totalCount! / widget.maxPageSize).ceil(),
              jumpToPage: _jumpToPage,
            ),
          ],
        ],
      ),
    );
  }
}

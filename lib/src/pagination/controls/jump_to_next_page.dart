import 'package:flutter/material.dart';
import 'package:micha_core/src/pagination/pagination_theme_data.dart';

class JumpToNextPage extends StatelessWidget {
  static const defaultIcon = Icon(Icons.chevron_right_rounded);

  final int currentPageIndex;
  final void Function(int index) jumpToPage;

  const JumpToNextPage({
    super.key,
    required this.currentPageIndex,
    required this.jumpToPage,
  });

  @override
  Widget build(BuildContext context) {
    final paginationTheme = Theme.of(context).extension<PaginationThemeData>();

    return IconButton(
      icon: paginationTheme?.jumpToNextPageIcon ?? defaultIcon,
      onPressed: () => jumpToPage(currentPageIndex + 1),
    );
  }
}

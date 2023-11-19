import 'package:flutter/material.dart';
import 'package:micha_core/src/pagination/pagination_theme_data.dart';

class JumpToPreviousPage extends StatelessWidget {
  static const defaultIcon = Icon(Icons.chevron_left_rounded);

  final int currentPageIndex;
  final void Function(int index) jumpToPage;

  const JumpToPreviousPage({
    super.key,
    required this.currentPageIndex,
    required this.jumpToPage,
  });

  @override
  Widget build(BuildContext context) {
    final paginationTheme = Theme.of(context).extension<PaginationThemeData>();

    return IconButton(
      icon: paginationTheme?.jumpToPreviousPageIcon ?? defaultIcon,
      onPressed: () => jumpToPage(currentPageIndex - 1),
    );
  }
}

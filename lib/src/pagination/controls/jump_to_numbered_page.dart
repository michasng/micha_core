import 'package:flutter/material.dart';
import 'package:micha_core/src/pagination/pagination_theme_data.dart';
import 'package:micha_core/src/text/link.dart';

class JumpToNumberedPage extends StatelessWidget {
  final int index;
  final void Function(int index) jumpToPage;

  const JumpToNumberedPage({
    super.key,
    required this.index,
    required this.jumpToPage,
  });

  @override
  Widget build(BuildContext context) {
    final paginationTheme = Theme.of(context).extension<PaginationThemeData>();

    return Link(
      onTap: () => jumpToPage(index),
      child: Text(
        (index + 1).toString(),
        style: paginationTheme?.jumpToNumberedPageStyle,
      ),
    );
  }
}

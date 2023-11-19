import 'package:flutter/material.dart';
import 'package:micha_core/src/pagination/pagination_theme_data.dart';

class CurrentPageLabel extends StatelessWidget {
  final int index;

  const CurrentPageLabel({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultStyle = theme.textTheme.headlineSmall;
    final paginationTheme = theme.extension<PaginationThemeData>();

    return Text(
      (index + 1).toString(),
      style: paginationTheme?.currentPageLabelStyle ?? defaultStyle,
    );
  }
}

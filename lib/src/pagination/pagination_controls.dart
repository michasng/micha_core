import 'package:flutter/material.dart';
import 'package:micha_core/src/extensions/separated.dart';
import 'package:micha_core/src/layout/gap.dart';
import 'package:micha_core/src/pagination/controls/current_page_label.dart';
import 'package:micha_core/src/pagination/controls/jump_to_next_page.dart';
import 'package:micha_core/src/pagination/controls/jump_to_numbered_page.dart';
import 'package:micha_core/src/pagination/controls/jump_to_previous_page.dart';
import 'package:micha_core/src/pagination/pagination_theme_data.dart';

class PaginationControls<T> extends StatelessWidget {
  static const defaultFiller = Text('...');

  final int pageCount;
  final int currentPageIndex;
  final void Function(int index) jumpToPage;
  final int showPreviousCount;
  final int showNextCount;
  final Widget? filler;

  const PaginationControls({
    super.key,
    required this.pageCount,
    required this.currentPageIndex,
    required this.jumpToPage,
    required this.showPreviousCount,
    required this.showNextCount,
    this.filler,
  });

  List<Widget> _buildNumberedControls(BuildContext context) {
    final paginationTheme = Theme.of(context).extension<PaginationThemeData>();
    final nonNullFillerControl =
        filler ?? paginationTheme?.fillerControl ?? defaultFiller;

    final List<Widget> controls = [];
    bool previousIsFiller = false;
    for (int i = 0; i < pageCount; i++) {
      if (i == currentPageIndex) {
        controls.add(CurrentPageLabel(index: i));
        previousIsFiller = false;
        continue;
      }

      if (i == 0 ||
          i == pageCount - 1 ||
          (i >= currentPageIndex - showPreviousCount && i < currentPageIndex) ||
          (i <= currentPageIndex + showNextCount && currentPageIndex < i)) {
        controls.add(JumpToNumberedPage(index: i, jumpToPage: jumpToPage));
        previousIsFiller = false;
        continue;
      }

      if (!previousIsFiller) {
        controls.add(nonNullFillerControl);
        previousIsFiller = true;
      }
    }
    return controls;
  }

  @override
  Widget build(BuildContext context) {
    const disabledButton = IconButton(onPressed: null, icon: SizedBox.shrink());

    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          currentPageIndex > 0
              ? JumpToPreviousPage(
                  currentPageIndex: currentPageIndex,
                  jumpToPage: jumpToPage,
                )
              : disabledButton,
          ..._buildNumberedControls(context),
          currentPageIndex < (pageCount - 1)
              ? JumpToNextPage(
                  currentPageIndex: currentPageIndex,
                  jumpToPage: jumpToPage,
                )
              : disabledButton,
        ].separated(const Gap()),
      ),
    );
  }
}

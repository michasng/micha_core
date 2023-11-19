import 'package:flutter/material.dart';
import 'package:micha_core/src/extensions/separated.dart';
import 'package:micha_core/src/layout/gap.dart';
import 'package:micha_core/src/pagination/controls/current_page_label.dart';
import 'package:micha_core/src/pagination/controls/jump_to_next_page.dart';
import 'package:micha_core/src/pagination/controls/jump_to_numbered_page.dart';
import 'package:micha_core/src/pagination/controls/jump_to_previous_page.dart';

class PaginationControls<T> extends StatelessWidget {
  final int pageCount;
  final int currentPageIndex;
  final void Function(int index) jumpToPage;
  final int showPreviousCount;
  final int showNextCount;
  final Widget fillerChild;

  const PaginationControls({
    super.key,
    required this.pageCount,
    required this.currentPageIndex,
    required this.jumpToPage,
    this.showPreviousCount = 1,
    this.showNextCount = 3,
    this.fillerChild = const Text('...'),
  });

  List<Widget> _buildNumberedControls(BuildContext context) {
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
        controls.add(
          JumpToNumberedPage(
            index: i,
            jumpToPage: jumpToPage,
          ),
        );
        previousIsFiller = false;
        continue;
      }

      if (!previousIsFiller) {
        controls.add(fillerChild);
        previousIsFiller = true;
      }
    }
    return controls;
  }

  @override
  Widget build(BuildContext context) {
    const disabledButton = IconButton(
      onPressed: null,
      icon: SizedBox.shrink(),
    );

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

import 'package:flutter/material.dart';

class JumpToNextPage extends StatelessWidget {
  final int currentPageIndex;
  final void Function(int index) jumpToPage;

  const JumpToNextPage({
    super.key,
    required this.currentPageIndex,
    required this.jumpToPage,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.chevron_right_rounded),
      onPressed: () => jumpToPage(currentPageIndex + 1),
    );
  }
}

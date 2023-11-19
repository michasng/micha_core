import 'package:flutter/material.dart';

class JumpToPreviousPage extends StatelessWidget {
  final int currentPageIndex;
  final void Function(int index) jumpToPage;

  const JumpToPreviousPage({
    super.key,
    required this.currentPageIndex,
    required this.jumpToPage,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.chevron_left_rounded),
      onPressed: () => jumpToPage(currentPageIndex - 1),
    );
  }
}

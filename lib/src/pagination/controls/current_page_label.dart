import 'package:flutter/material.dart';

class CurrentPageLabel extends StatelessWidget {
  final int index;

  const CurrentPageLabel({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      (index + 1).toString(),
    );
  }
}

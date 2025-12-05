import 'package:flutter/material.dart';

class LayoutSliver extends StatelessWidget {
  final void Function(bool isAtTop)? onPositionChanged;

  const LayoutSliver({this.onPositionChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero).dy;
          final isAtTop = position <= kToolbarHeight + 5;

          onPositionChanged?.call(isAtTop);
        }

        return // your sliver content
        Container(height: 300, color: Colors.red);
      },
    );
  }
}

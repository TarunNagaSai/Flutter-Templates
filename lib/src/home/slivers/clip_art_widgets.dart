import 'package:flutter/material.dart';

class ClipArtWidgets extends StatelessWidget {
  const ClipArtWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final box = context.findRenderObject() as RenderBox?;
          if (box != null) {
            final position = box.localToGlobal(Offset.zero).dy;
            final isAtTop = position <= kToolbarHeight + 5;
          }
          return Text("Clip Art Widgets Coming Soon!");
        },
      ),
    );
  }
}

class LayoutWidget extends StatelessWidget {
  const LayoutWidget({super.key, required this.onReachedTap});

  final void Function() onReachedTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero).dy;
          final isAtTop = position <= kToolbarHeight + 5;
          onReachedTap();
        }
        return Text("Clip Art Widgets Coming Soon!");
      },
    );
  }
}

import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  const LayoutWidget({
    super.key,
    required this.onPositionChanged,
    required this.child,
  });

  final void Function(bool isAtTop)? onPositionChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final renderBox = context.findRenderObject() as RenderBox?;
            if (renderBox != null && renderBox.hasSize) {
              final position = renderBox.localToGlobal(Offset.zero).dy;
              final isAtTop = position <= kToolbarHeight + 5;
              if (isAtTop) {
                onPositionChanged?.call(isAtTop);
              }
            }
          });

          return child;
        },
      ),
    );
  }
}

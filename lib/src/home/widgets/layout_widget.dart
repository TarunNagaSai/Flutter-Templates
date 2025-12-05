import 'package:animations/src/providers/title_animation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LayoutWidget extends ConsumerStatefulWidget {
  const LayoutWidget({
    super.key,
    required this.child,
    required this.title,
    required this.sectionKey,
  });

  final Widget child;
  final String title;
  final GlobalKey sectionKey;

  @override
  ConsumerState<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends ConsumerState<LayoutWidget> {
  String? mostVisibleSliver;
  @override
  Widget build(BuildContext context) {
    // Map to track visibility of all slivers
    final Map<String, double> visibilityMap = {};
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        // Calculate the total extent of your sliver content
        final sliverHeight = MediaQuery.of(context).size.height;

        // Calculate visible portion
        final overlap = constraints.overlap;
        final remainingPaint = constraints.remainingPaintExtent;

        double visibleHeight;
        if (overlap > 0) {
          visibleHeight = (sliverHeight - overlap).clamp(0.0, sliverHeight);
        } else {
          visibleHeight = remainingPaint.clamp(0.0, sliverHeight);
        }

        final visibilityRatio = visibleHeight / sliverHeight;

        // Store visibility for this sliver
        visibilityMap["name"] = visibilityRatio;

        // After all slivers are built, find the most visible one
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final mostVisible = visibilityMap.entries.reduce(
            (a, b) => a.value > b.value ? a : b,
          );
          if (mostVisible.value >= 0.9 &&
              mostVisibleSliver != mostVisible.key) {
            setState(() {
              mostVisibleSliver = mostVisible.key;
            });
            ref.read(titleModeProvider.notifier).state = widget.title;
          }
        });
        return SliverToBoxAdapter(
          child: SizedBox(
            key: widget.sectionKey,
            height: MediaQuery.of(context).size.height,
            child: widget.child,
          ),
        );
      },
    );
  }
}

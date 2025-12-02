import 'package:flutter/material.dart';

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  StickyHeaderDelegate({
    required this.builder,
    required this.minHeight,
    required this.maxHeight,
  });

  final Widget Function(bool isPinned, double sizeWidth) builder;
  final double minHeight;
  final double maxHeight;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isPinned = shrinkOffset > (maxHeight - minHeight - 1.0);
    final sizeWidth = MediaQuery.of(context).size.width;

    return builder(isPinned, sizeWidth);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

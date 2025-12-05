import 'package:animations/src/home/animations/arrow_up_animation.dart';
import 'package:animations/src/home/slivers/slivers.dart';
import 'package:animations/src/providers/animation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin {
  final GlobalKey<ArrowUpAnimationState> _childKey =
      GlobalKey<ArrowUpAnimationState>();

  ScrollController scrollController = ScrollController();
  List<Widget> sliverChildren = [];

  @override
  void initState() {
    scrollController.addListener(() {
      final direction = scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.reverse) {
        _childKey.currentState?.startFadeOut();
      }
    });
    sliverChildren = SliverSections.generateSliverList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool scrollEnabled = false;
    final isAnimationCompleted = ref.watch(animationStatusProvider);
    if (isAnimationCompleted) {
      _childKey.currentState?.startFadeIn();
      scrollEnabled = true;
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Scrollbar(
              controller: scrollController,
              child: CustomScrollView(
                controller: scrollController,
                physics: scrollEnabled
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                slivers: SliverSections.generateSliverList(),
              ),
            ),
          ),
          // Your arrow
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: ArrowUpAnimation(key: _childKey),
          ),
        ],
      ),
    );
  }
}

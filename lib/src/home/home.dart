import 'package:animations/src/home/animations/arrow_up_animation.dart';
import 'package:animations/src/home/slivers/slivers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final AnimationController lottieController;
  final GlobalKey<ArrowUpAnimationState> _childKey =
      GlobalKey<ArrowUpAnimationState>();

  ScrollController scrollController = ScrollController();
  List<Widget> sliverChildren = [];

  bool _scrollEnabled = false;

  @override
  void initState() {
    lottieController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _childKey.currentState?.startFadeIn();
        setState(() {
          _scrollEnabled = true;
        });
      }
    });

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
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Scrollbar(
              controller: scrollController,
              child: CustomScrollView(
                controller: scrollController,
                physics: _scrollEnabled
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                slivers: sliverChildren.isNotEmpty
                    ? sliverChildren
                    : [SliverSections.sliverList[0]],
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

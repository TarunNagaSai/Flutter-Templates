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

  bool _scrollEnabled = false;
  @override
  void initState() {
    super.initState();
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
            child: CustomScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),

              // _scrollEnabled
              //     ? const BouncingScrollPhysics()
              //     : const NeverScrollableScrollPhysics(),
              slivers: sliverList,
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

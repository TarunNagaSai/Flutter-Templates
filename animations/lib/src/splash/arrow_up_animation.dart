import 'package:flutter/material.dart';

class ArrowUpAnimation extends StatefulWidget {
  const ArrowUpAnimation({super.key});

  @override
  State<ArrowUpAnimation> createState() => ArrowUpAnimationState();
}

class ArrowUpAnimationState extends State<ArrowUpAnimation>
    with TickerProviderStateMixin {
  /// Initialize the controller in initState because `this` isn't available at
  /// field initialization time.
  late final Animation<AlignmentGeometry> _animation;

  /// Animation controller for the arrow animation
  late final AnimationController _controller;

  /// Animation controller for the fade animation
  late final AnimationController _fadeAnimationController;

  ///
  late final Animation<double> _fade;
  @override
  void initState() {
    super.initState();

    /// Fade Animation Controller
    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fade = CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeIn,
    );

    /// Floating Arrow Animation Controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<AlignmentGeometry>(
      begin: Alignment.center,
      end: Alignment.bottomCenter,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));
  }

  void startFadeIn() {
    _fadeAnimationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SizedBox(
        height: 100,
        child: AlignTransition(
          alignment: _animation,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Icon(Icons.keyboard_double_arrow_up_rounded, size: 40),
          ),
        ),
      ),
    );
  }
}

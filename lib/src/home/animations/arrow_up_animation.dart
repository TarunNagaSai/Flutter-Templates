import 'package:flutter/material.dart';

class ArrowUpAnimation extends StatefulWidget {
  const ArrowUpAnimation({super.key});

  @override
  State<ArrowUpAnimation> createState() => ArrowUpAnimationState();
}

class ArrowUpAnimationState extends State<ArrowUpAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _fadeAnimationController;

  late final Animation<double> _fade;
  late final Animation<Alignment> _alignment;

  @override
  void initState() {
    super.initState();

    /// Fade Animation
    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fade = CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeIn,
    );

    /// Floating arrow animation
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _alignment = AlignmentTween(
      begin: Alignment.center,
      end: Alignment(0, 0.8), // better than bottomCenter
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void startFadeIn() {
    _fadeAnimationController.forward();
  }

  void startFadeOut() {
    _fadeAnimationController.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SizedBox(
        height: 100,
        child: AnimatedBuilder(
          animation: _alignment,
          builder: (context, child) {
            return Align(alignment: _alignment.value, child: child);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Icon(Icons.keyboard_double_arrow_up_rounded, size: 40),
          ),
        ),
      ),
    );
  }
}

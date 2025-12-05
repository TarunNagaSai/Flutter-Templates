import 'package:animations/gen/assets.gen.dart';
import 'package:animations/src/providers/animation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeSliver extends ConsumerStatefulWidget {
  const WelcomeSliver({super.key});

  @override
  ConsumerState<WelcomeSliver> createState() => _WelcomeSliverState();
}

class _WelcomeSliverState extends ConsumerState<WelcomeSliver>
    with TickerProviderStateMixin {
  late final AnimationController lottieController;

  @override
  void initState() {
    super.initState();
    lottieController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();

    lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ref.read(animationStatusProvider.notifier).state = true;
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
    return SliverFillRemaining(
      child: Center(
        child: Assets.lottie.welcome.lottie(
          controller: lottieController,
          animate: true,
          repeat: false,
        ),
      ),
    );
  }
}

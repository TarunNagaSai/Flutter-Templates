import 'package:animations/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class WelcomeSliver extends StatelessWidget {
  const WelcomeSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Assets.lottie.welcome.lottie(animate: true, repeat: false),
    );
  }
}

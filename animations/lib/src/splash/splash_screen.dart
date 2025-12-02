import 'package:animations/gen/assets.gen.dart';
import 'package:animations/src/splash/arrow_up_animation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Initialize the controller in initState because `this` isn't available at
  // field initialization time.
  late final AnimationController lottieController;
  final GlobalKey<ArrowUpAnimationState> _childKey =
      GlobalKey<ArrowUpAnimationState>();

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
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          details.globalPosition;
        },
        onTap: () {
          print("ON Tap up");
        },
        child: Stack(
          alignment: AlignmentGeometry.bottomCenter,
          children: [
            Column(
              children: [
                Expanded(
                  child: Center(
                    child: Assets.lottie.welcome.lottie(
                      animate: true,
                      repeat: false,
                    ),
                  ),
                ),
              ],
            ),
            ArrowUpAnimation(key: _childKey),
          ],
        ),
      ),
    );
  }
}

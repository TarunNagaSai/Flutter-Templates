import 'package:flutter/material.dart';

class ParallaxEffects extends StatelessWidget {
  const ParallaxEffects({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Text("Parallax Effects Coming Soon!"),
    );
  }
}

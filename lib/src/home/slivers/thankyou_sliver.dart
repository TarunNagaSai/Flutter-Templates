import 'package:animations/core/extensions_methods.dart';
import 'package:flutter/material.dart';

class ThankyouSliver extends StatelessWidget {
  const ThankyouSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: DecoratedBox(
        decoration: BoxDecoration(color: context.colors.inverseSurface),
        child: Center(
          child: Text(
            "Thank You Sliver",
            style: context.themeText.headlineMedium?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

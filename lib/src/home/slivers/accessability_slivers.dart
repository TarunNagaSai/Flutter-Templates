import 'package:animations/core/extensions_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AccessabilitySlivers extends StatefulWidget {
  const AccessabilitySlivers({super.key});

  @override
  State<AccessabilitySlivers> createState() => _AccessabilitySliversState();
}

class _AccessabilitySliversState extends State<AccessabilitySlivers> {
  double _scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: .end,
                  mainAxisAlignment: .center,
                  children: [
                    SizedBox(
                      height: 150,
                      child: AnimatedScale(
                        scale: _scale,
                        duration: Duration(milliseconds: 300),
                        child: RichText(
                          text: TextSpan(
                            text: 'A',
                            style: context.themeText.displayLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 120,
                            ),
                            children: [
                              TextSpan(
                                text: 'A',
                                style: context.themeText.displayLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text("0.5"),
                    PlatformSlider(
                      value: _scale,
                      min: 0.5,
                      max: 1.5,
                      divisions: 4,
                      onChanged: (value) {
                        setState(() {
                          _scale = value;
                        });
                      },
                    ),
                    Text("1.5"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

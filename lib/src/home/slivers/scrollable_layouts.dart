import 'package:flutter/material.dart';

class ScrollableLayouts extends StatelessWidget {
  const ScrollableLayouts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Text("Scrollable Slivers Coming Soon!"),
    );
  }
}

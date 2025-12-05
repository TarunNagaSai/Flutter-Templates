import 'package:flutter/material.dart';

class LoadingSlivers extends StatelessWidget {
  const LoadingSlivers({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Text("Clip Art Widgets Coming Soon!"),
    );
  }
}

import 'package:flutter/material.dart';

class CustomPopupsSlivers extends StatelessWidget {
  const CustomPopupsSlivers({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Text("Custom Popup Widgets Coming Soon!"),
    );
  }
}

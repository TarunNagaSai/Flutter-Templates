import 'package:flutter/material.dart';

class LocalCustomNotifications extends StatelessWidget {
  const LocalCustomNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Text("Local Custom Notifications Coming Soon!"),
    );
  }
}

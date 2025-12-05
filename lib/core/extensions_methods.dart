import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

extension BuildContextExtension on BuildContext {
  TextTheme get themeText => Theme.of(this).textTheme;

  ColorScheme get colors => Theme.of(this).colorScheme;

  Size get screenSize => MediaQuery.of(this).size;
}

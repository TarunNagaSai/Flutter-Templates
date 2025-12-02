import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system; // default theme
});

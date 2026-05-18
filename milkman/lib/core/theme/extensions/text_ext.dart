import 'package:flutter/material.dart';

extension ThemeExt on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  ThemeMode get themeMode => Theme.of(this).brightness == Brightness.dark
      ? ThemeMode.dark
      : ThemeMode.light;
  ColorScheme get colors => Theme.of(this).colorScheme;
}

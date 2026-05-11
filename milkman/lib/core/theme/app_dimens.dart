import 'package:flutter/material.dart';

abstract final class AppDimens {
  // 8pt grid
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const double radiusSm = 12;
  static const double radiusMd = 16;
  static const double radiusLg = 20;

  static const double borderWidth = 1;

  // Material 3-ish elevation feel
  static List<BoxShadow> softShadow({bool dark = false}) => [
    BoxShadow(
      blurRadius: 20,
      offset: const Offset(0, 6),
      color: (dark ? Colors.black : Colors.black).withOpacity(
        dark ? 0.35 : 0.08,
      ),
    ),
  ];
}

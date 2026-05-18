import 'package:flutter/material.dart';

abstract final class AppTypography {
  static TextTheme base(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double scale;

    if (width < 600) {
      scale = 1.0;
    } else if (width < 900) {
      scale = 1.2;
    } else {
      scale = 1.4;
    }

    final base = Theme.of(context).textTheme;

    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontSize: 28 * scale,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        fontSize: 24 * scale,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: 22 * scale,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontSize: 20 * scale,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 18 * scale,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontSize: 16 * scale,
        fontWeight: FontWeight.w600,
        height: 1.35,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 14 * scale,
        fontWeight: FontWeight.w500,
        height: 1.45,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 12 * scale,
        fontWeight: FontWeight.w500,
        height: 1.40,
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontSize: 10 * scale,
        fontWeight: FontWeight.w500,
        height: 1.35,
      ),
    );
  }
}

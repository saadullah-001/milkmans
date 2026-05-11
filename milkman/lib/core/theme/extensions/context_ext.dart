import 'dart:math' as math;
import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
  Size get size => mq.size;
  double get shortestSide => math.min(size.width, size.height);

  /// Responsive scale based on device size:
  /// - 360 is "baseline" phone width (approx)
  /// - clamps to avoid wild scaling on tablets / tiny devices
  double get uiScale {
    final base = shortestSide / 360.0;
    return base.clamp(0.90, 1.20);
  }

  /// System text scale factor; clamp to keep UI stable.
  double get sysTextScale => mq.textScaler.scale(1.0).clamp(0.90, 1.25);

  /// Combined scale you can use for typography.
  double get textScale => (uiScale * sysTextScale).clamp(0.90, 1.25);

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

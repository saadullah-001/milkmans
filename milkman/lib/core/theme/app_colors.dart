import 'package:flutter/material.dart';

/// Brand colors: Trust Blue + Organic Green + Milk White
abstract final class AppColors {
  // Light
  static const Color primary = Color(0xFF1E88E5);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color organic = Color(0xFF43A047);
  static const Color milk = Color(0xFFF8FAFC);
  static const Color background = Color(0xFFF4F8FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color outline = Color(0xFFE3ECF5);
  static const Color text = Color(0xFF1E293B);
  static const Color textMuted = Color(0xFF64748B);

  // Status
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFE53935);

  // Dark
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkOutline = Color(0xFF334155);
  static const Color darkText = Color(0xFFE2E8F0);
  static const Color darkTextMuted = Color(0xFF94A3B8);
  static const Color darkPrimary = Color(0xFF64B5F6);
  static const Color darkOrganic = Color(0xFF66BB6A);
}

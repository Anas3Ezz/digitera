import 'package:flutter/material.dart';

/// Shared design tokens for the premium dark theme.
/// Lives in core because it is reused across auth screens (login, register, ...).
class AppColors {
  const AppColors._();

  static const Color background = Color(0xFF0B1120);
  static const Color backgroundEnd = Color(0xFF141B2D);
  static const Color surface = Color(0xFF141B2D);
  static const Color surfaceVariant = Color(0xFF1C2438);
  static const Color border = Color(0xFF2A3348);

  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF1D477);

  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color error = Color(0xFFEF4444);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [background, backgroundEnd],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gold, goldLight],
  );
}

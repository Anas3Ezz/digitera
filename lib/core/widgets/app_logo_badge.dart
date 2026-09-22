import 'package:digitira/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Circular gold-gradient brand badge shown on auth screens (login, register, ...).
class AppLogoBadge extends StatelessWidget {
  const AppLogoBadge({super.key, this.letter = 'D', this.size = 76});

  final String letter;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppColors.goldGradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          color: AppColors.background,
          fontSize: size * 0.44,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

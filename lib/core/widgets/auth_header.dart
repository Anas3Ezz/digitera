import 'package:digitira/core/theme/app_colors.dart';
import 'package:digitira/core/widgets/app_logo_badge.dart';
import 'package:flutter/material.dart';

/// Shared header for auth screens (login, register, ...): logo badge,
/// title and subtitle. Only the copy differs between screens.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppLogoBadge(),
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
      ],
    );
  }
}

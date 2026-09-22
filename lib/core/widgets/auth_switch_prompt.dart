import 'package:digitira/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Shared "Don't have an account? Register" / "Already have an account? Login"
/// row used on auth screens to switch between them.
class AuthSwitchPrompt extends StatelessWidget {
  const AuthSwitchPrompt({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.targetRouteName,
  });

  final String promptText;
  final String actionText;
  final String targetRouteName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(promptText, style: const TextStyle(color: AppColors.textSecondary)),
        TextButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed(targetRouteName),
          style: TextButton.styleFrom(foregroundColor: AppColors.gold),
          child: Text(actionText, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

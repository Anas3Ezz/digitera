import 'package:digitira/core/theme/app_colors.dart';
import 'package:digitira/core/widgets/app_password_field.dart';
import 'package:digitira/core/widgets/app_primary_button.dart';
import 'package:digitira/core/widgets/app_text_field.dart';
import 'package:digitira/core/widgets/auth_card.dart';
import 'package:digitira/feature/auth/cubit/login_cubit.dart';
import 'package:digitira/feature/auth/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.onEmailSubmitted,
    required this.onSubmit,
    required this.emailValidator,
    required this.passwordValidator,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final VoidCallback onEmailSubmitted;
  final VoidCallback onSubmit;
  final String? Function(String?) emailValidator;
  final String? Function(String?) passwordValidator;

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: emailController,
            label: 'Email',
            hint: 'you@example.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: emailValidator,
            onFieldSubmitted: (_) => onEmailSubmitted(),
          ),
          const SizedBox(height: 16),
          AppPasswordField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            textInputAction: TextInputAction.done,
            validator: passwordValidator,
            onFieldSubmitted: (_) => onSubmit(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: AppColors.gold),
              child: const Text('Forgot password?', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 8),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return AppPrimaryButton(
                label: 'Login',
                isLoading: state.status == Status.loading,
                onPressed: onSubmit,
              );
            },
          ),
        ],
      ),
    );
  }
}

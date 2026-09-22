import 'package:digitira/core/widgets/app_password_field.dart';
import 'package:digitira/core/widgets/app_primary_button.dart';
import 'package:digitira/core/widgets/app_text_field.dart';
import 'package:digitira/core/widgets/auth_card.dart';
import 'package:digitira/feature/auth/cubit/login_state.dart' show Status;
import 'package:digitira/feature/auth/cubit/register_cubit.dart';
import 'package:digitira/feature/auth/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCard extends StatelessWidget {
  const RegisterCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
    required this.onSubmit,
    required this.nameValidator,
    required this.emailValidator,
    required this.passwordValidator,
    required this.confirmPasswordValidator,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  final VoidCallback onSubmit;
  final String? Function(String?) nameValidator;
  final String? Function(String?) emailValidator;
  final String? Function(String?) passwordValidator;
  final String? Function(String?) confirmPasswordValidator;

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: nameController,
            label: 'Full name',
            hint: 'John Doe',
            prefixIcon: Icons.person_outline,
            textInputAction: TextInputAction.next,
            validator: nameValidator,
            onFieldSubmitted: (_) => emailFocusNode.requestFocus(),
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: emailController,
            focusNode: emailFocusNode,
            label: 'Email',
            hint: 'you@example.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: emailValidator,
            onFieldSubmitted: (_) => passwordFocusNode.requestFocus(),
          ),
          const SizedBox(height: 16),
          AppPasswordField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            textInputAction: TextInputAction.next,
            validator: passwordValidator,
            onFieldSubmitted: (_) => confirmPasswordFocusNode.requestFocus(),
          ),
          const SizedBox(height: 16),
          AppPasswordField(
            controller: confirmPasswordController,
            focusNode: confirmPasswordFocusNode,
            label: 'Confirm password',
            textInputAction: TextInputAction.done,
            validator: confirmPasswordValidator,
            onFieldSubmitted: (_) => onSubmit(),
          ),
          const SizedBox(height: 20),
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return AppPrimaryButton(
                label: 'Create Account',
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

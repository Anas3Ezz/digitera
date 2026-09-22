import 'package:digitira/core/di/service_locator.dart';
import 'package:digitira/core/theme/app_colors.dart';
import 'package:digitira/core/widgets/app_password_field.dart';
import 'package:digitira/core/widgets/app_primary_button.dart';
import 'package:digitira/core/widgets/app_text_field.dart';
import 'package:digitira/feature/auth/cubit/login_cubit.dart';
import 'package:digitira/feature/auth/cubit/login_state.dart';
import 'package:digitira/feature/auth/data/model/login_request_model.dart';
import 'package:digitira/feature/auth/data/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(getIt<LoginRepo>()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context.read<LoginCubit>().login(
          LoginRequestModel(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status == Status.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.surfaceVariant,
                    content: Text(state.message ?? 'Something went wrong'),
                  ),
                );
              }
              if (state.status == Status.sucess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.surfaceVariant,
                    content: Text(state.message ?? 'Logged in successfully'),
                  ),
                );
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    const _LoginHeader(),
                    const SizedBox(height: 36),
                    _LoginCard(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      passwordFocusNode: _passwordFocusNode,
                      onEmailSubmitted: () => _passwordFocusNode.requestFocus(),
                      onSubmit: () => _submit(context),
                      emailValidator: _validateEmail,
                      passwordValidator: _validatePassword,
                    ),
                    const SizedBox(height: 28),
                    const _RegisterPrompt(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _LogoBadge(),
        SizedBox(height: 24),
        Text(
          'Welcome Back',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Sign in to continue to your account',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
      ],
    );
  }
}

class _LogoBadge extends StatelessWidget {
  const _LogoBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
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
      child: const Text(
        'D',
        style: TextStyle(
          color: AppColors.background,
          fontSize: 34,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard({
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
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
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

class _RegisterPrompt extends StatelessWidget {
  const _RegisterPrompt();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?", style: TextStyle(color: AppColors.textSecondary)),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(foregroundColor: AppColors.gold),
          child: const Text('Register', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

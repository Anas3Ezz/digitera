import 'package:digitira/core/routes/app_routes.dart';
import 'package:digitira/core/theme/app_colors.dart';
import 'package:digitira/core/utils/validators.dart';
import 'package:digitira/core/widgets/auth_header.dart';
import 'package:digitira/core/widgets/auth_switch_prompt.dart';
import 'package:digitira/feature/auth/cubit/login_state.dart' show Status;
import 'package:digitira/feature/auth/cubit/register_cubit.dart';
import 'package:digitira/feature/auth/cubit/register_state.dart';
import 'package:digitira/feature/auth/data/model/register_request_model.dart';
import 'package:digitira/feature/auth/ui/widgets/register_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The BlocProvider for [RegisterCubit] is supplied by the router
/// (see AppRouter), not here, so this screen stays a plain widget.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    return AppValidators.confirmPassword(value, _passwordController.text);
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context.read<RegisterCubit>().register(
          RegisterRequestModel(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            passwordConfirmation: _confirmPasswordController.text,
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
          child: BlocListener<RegisterCubit, RegisterState>(
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
                    content: Text(state.message ?? 'Account created successfully'),
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
                    const SizedBox(height: 12),
                    const AuthHeader(
                      title: 'Create Account',
                      subtitle: 'Sign up to get started',
                    ),
                    const SizedBox(height: 32),
                    RegisterCard(
                      nameController: _nameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      emailFocusNode: _emailFocusNode,
                      passwordFocusNode: _passwordFocusNode,
                      confirmPasswordFocusNode: _confirmPasswordFocusNode,
                      onSubmit: () => _submit(context),
                      nameValidator: AppValidators.name,
                      emailValidator: AppValidators.email,
                      passwordValidator: AppValidators.password,
                      confirmPasswordValidator: _validateConfirmPassword,
                    ),
                    const SizedBox(height: 28),
                    const AuthSwitchPrompt(
                      promptText: 'Already have an account?',
                      actionText: 'Login',
                      targetRouteName: AppRoutes.loginScreen,
                    ),
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

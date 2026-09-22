import 'package:digitira/core/di/service_locator.dart';
import 'package:digitira/core/routes/app_routes.dart';
import 'package:digitira/feature/auth/cubit/login_cubit.dart';
import 'package:digitira/feature/auth/cubit/register_cubit.dart';
import 'package:digitira/feature/auth/ui/login_screen.dart';
import 'package:digitira/feature/auth/ui/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case AppRoutes.registerScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );
      default:
        return null;
    }
  }
}

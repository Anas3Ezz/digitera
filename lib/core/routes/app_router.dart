import 'package:digitira/core/routes/app_routes.dart';
import 'package:digitira/feature/auth/ui/login_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route? onGenerateRoutes(RouteSettings settings){
    switch (settings.name) {
      case AppRoutes.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
        
      default:
    }
  }
}

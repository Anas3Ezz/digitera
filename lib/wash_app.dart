import 'package:digitira/core/routes/app_router.dart';
import 'package:digitira/core/routes/app_routes.dart';
import 'package:digitira/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        canvasColor: AppColors.background,
      ),
      initialRoute: AppRoutes.loginScreen,
     onGenerateRoute: AppRouter.onGenerateRoutes,
    );
  }
}
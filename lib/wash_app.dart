import 'package:digitira/core/routes/app_router.dart';
import 'package:digitira/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.regiesterScreen,
     onGenerateRoute: AppRouter.onGenerateRoutes,
    );
  }
}
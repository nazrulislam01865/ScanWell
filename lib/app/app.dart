import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import 'routes/app_routes.dart';

class ScanWellApp extends StatelessWidget {
  const ScanWellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ScanWell',
      theme: AppTheme.light,
      initialRoute: AppRoutes.onboarding,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}

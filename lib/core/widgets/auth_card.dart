import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../layout/responsive_layout.dart';

class AuthCard extends StatelessWidget {
  const AuthCard({
    required this.child,
    this.padding,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ??
          EdgeInsets.all(
            ResponsiveLayout.value(
              context,
              compact: AppSpacing.v16,
              phone: AppSpacing.v18,
              tablet: AppSpacing.v22,
            ),
          ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadii.v18),
      ),
      child: child,
    );
  }
}

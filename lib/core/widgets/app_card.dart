import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';


class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.color = AppColors.white,
    this.borderRadius = 14,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.softCard,
      ),
      child: child,
    );
  }
}

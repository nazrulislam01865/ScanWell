import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

class SecurityNote extends StatelessWidget {
  const SecurityNote({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          AppIcons.shield_outlined,
          size: AppSizes.iconControl,
          color: AppColors.primary,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.preDashboardSupporting,
          ),
        ),
      ],
    );
  }
}

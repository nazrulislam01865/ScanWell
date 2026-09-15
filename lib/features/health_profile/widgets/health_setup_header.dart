import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

class HealthSetupHeader extends StatelessWidget {
  const HealthSetupHeader({
    required this.step,
    required this.onBack,
    super.key,
  });

  final int step;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppSizes.v54,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  key: const Key('health-setup-back'),
                  onPressed: onBack,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: AppSizes.v40,
                    height: AppSizes.v40,
                  ),
                  icon: const Icon(
                    AppIcons.arrow_back_ios_new_rounded,
                    color: AppColors.textPrimary,
                    size: AppSizes.iconControl,
                  ),
                ),
              ),
              Image.asset(
                AppAssets.scanwellWordmark,
                width: AppSizes.v138,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              width: AppSizes.v10,
              height: AppSizes.v10,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == step - 1
                    ? AppColors.primary
                    : AppColors.toneFFE3E5E7,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.v8),
        Text('$step of 3', style: AppTextStyles.healthSetupStep),
      ],
    );
  }
}

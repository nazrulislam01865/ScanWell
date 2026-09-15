import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../data/consumer_product.dart';

class HealthFlagBadge extends StatelessWidget {
  const HealthFlagBadge({
    required this.flag,
    this.compact = false,
    super.key,
  });

  final HealthFlag flag;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(flag);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppSpacing.v9 : AppSpacing.v11,
        vertical: compact ? AppSpacing.v6 : AppSpacing.v7,
      ),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(AppRadii.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: compact ? AppSizes.v17 : AppSizes.v19,
            height: compact ? AppSizes.v17 : AppSizes.v19,
            decoration: BoxDecoration(
              color: style.foreground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              style.icon,
              size: compact ? AppSizes.v12 : AppSizes.v13,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: AppSizes.v6),
          Text(
            style.label,
            maxLines: 1,
            style: AppTextStyle(
              color: style.foreground,
              fontSize: compact ? AppTypography.font11 : AppTypography.font12,
              height: AppTypography.lineHeight1,
              fontWeight: AppTypography.weight700,
            ),
          ),
        ],
      ),
    );
  }
}

class _FlagStyle {
  const _FlagStyle({
    required this.label,
    required this.icon,
    required this.foreground,
    required this.background,
  });

  final String label;
  final IconData icon;
  final Color foreground;
  final Color background;
}

_FlagStyle _styleFor(HealthFlag flag) {
  switch (flag) {
    case HealthFlag.looksOkay:
      return const _FlagStyle(
        label: 'Looks Okay',
        icon: AppIcons.check_rounded,
        foreground: AppColors.primary,
        background: AppColors.toneFFEAF8E6,
      );
    case HealthFlag.useWithCaution:
      return const _FlagStyle(
        label: 'Use with Caution',
        icon: AppIcons.priority_high_rounded,
        foreground: AppColors.toneFFF0A300,
        background: AppColors.toneFFFFF5DE,
      );
    case HealthFlag.highConcern:
      return const _FlagStyle(
        label: 'High Concern',
        icon: AppIcons.priority_high_rounded,
        foreground: AppColors.toneFFE52D39,
        background: AppColors.toneFFFFE8EA,
      );
  }
}

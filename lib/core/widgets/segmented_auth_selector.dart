import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../layout/responsive_layout.dart';

class SegmentedAuthSelector extends StatelessWidget {
  const SegmentedAuthSelector({
    required this.leftLabel,
    required this.rightLabel,
    required this.leftIcon,
    required this.rightIcon,
    required this.leftSelected,
    required this.onChanged,
    super.key,
  });

  final String leftLabel;
  final String rightLabel;
  final IconData leftIcon;
  final IconData rightIcon;
  final bool leftSelected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final baseHeight = compact ? AppSizes.v48 : AppSizes.v50;
    final height =
        baseHeight + ((textScale - 1).clamp(0.0, 1.0) * AppSizes.v10);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _Segment(
              label: leftLabel,
              icon: leftIcon,
              selected: leftSelected,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _Segment(
              label: rightLabel,
              icon: rightIcon,
              selected: !leftSelected,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);

    return Material(
      color: selected ? AppColors.softGreen : AppColors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? AppSpacing.v7 : AppSpacing.v10,
            vertical: compact ? AppSpacing.sm : AppSpacing.v10,
          ),
          decoration: selected
              ? BoxDecoration(
                  border: Border.all(color: AppColors.toneFFC8E7D4),
                  borderRadius: BorderRadius.circular(AppRadii.card),
                )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: compact ? AppSizes.iconMd : AppSizes.v22,
                color: selected ? AppColors.primary : AppColors.textPrimary,
              ),
              SizedBox(width: compact ? AppSpacing.xs : AppSpacing.sm),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    maxLines: 1,
                    softWrap: false,
                    textAlign: TextAlign.center,
                    style: AppTextStyle(
                      fontSize: compact
                          ? AppTypography.font12_5
                          : AppTypography.font13_5,
                      height: AppTypography.lineHeight1_1,
                      fontWeight: selected
                          ? AppTypography.weight600
                          : AppTypography.weight500,
                      color: selected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

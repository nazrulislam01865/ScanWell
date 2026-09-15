import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';


class WorkflowSectionCard extends StatelessWidget {
  const WorkflowSectionCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.v14),
    this.borderColor = AppColors.border,
    this.backgroundColor = AppColors.white,
    this.borderRadius = 14,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color borderColor;
  final Color backgroundColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
        boxShadow: AppShadows.softCard,
      ),
      child: child,
    );
  }
}

class WorkflowSectionTitle extends StatelessWidget {
  const WorkflowSectionTitle({
    required this.index,
    required this.title,
    required this.icon,
    super.key,
  });

  final int index;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: AppSizes.iconControlTight, color: AppColors.primaryDark),
        const SizedBox(width: AppSizes.v9),
        Expanded(
          child: Text(
            '$index. $title',
            style: AppTextStyles.workflowSectionTitle,
          ),
        ),
      ],
    );
  }
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.label,
    required this.foreground,
    required this.background,
    this.icon,
    super.key,
  });

  final String label;
  final Color foreground;
  final Color background;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v9, vertical: AppSpacing.v5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.v7),
        border: Border.all(color: foreground.withOpacity(AppOpacity.v0_22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppSizes.iconBadge, color: foreground),
            const SizedBox(width: AppSizes.v5),
          ],
          Text(
            label,
            style: AppTextStyle(
              color: foreground,
              fontSize: AppTypography.font11,
              height: AppTypography.lineHeight1,
              fontWeight: AppTypography.weight700,
            ),
          ),
        ],
      ),
    );
  }
}

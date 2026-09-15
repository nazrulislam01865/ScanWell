import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';


class WorkflowAppBar extends StatelessWidget {
  const WorkflowAppBar({
    required this.title,
    this.subtitle,
    this.onBack,
    this.actions = const <Widget>[],
    this.centerTitle = true,
    this.showDivider = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onBack;
  final List<Widget> actions;
  final bool centerTitle;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: subtitle == null ? AppSizes.v58 : AppSizes.v70,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.divider))
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.v48,
            child: onBack == null
                ? null
                : IconButton(
                    onPressed: onBack,
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      AppIcons.arrow_back_rounded,
                      color: AppColors.primaryDark,
                      size: AppSizes.iconNavigation,
                    ),
                  ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: centerTitle
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                  style: AppTextStyles.workflowTitle.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSizes.v4),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                    style: AppTextStyles.workflowSubtitle,
                  ),
                ],
              ],
            ),
          ),
          SizedBox(
            width: actions.isEmpty ? AppSizes.v48 : null,
            child: actions.isEmpty
                ? null
                : Row(mainAxisSize: MainAxisSize.min, children: actions),
          ),
        ],
      ),
    );
  }
}

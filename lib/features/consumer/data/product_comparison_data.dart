import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';


class ComparisonMetric {
  const ComparisonMetric({
    required this.label,
    required this.value,
    required this.level,
    required this.icon,
    required this.levelColor,
  });

  final String label;
  final String value;
  final String level;
  final IconData icon;
  final Color levelColor;
}

class ComparisonProduct {
  const ComparisonProduct({
    required this.name,
    required this.imageAsset,
    required this.statusLabel,
    required this.statusIcon,
    required this.statusColor,
    required this.statusBackground,
    required this.metrics,
    required this.warning,
    required this.warningIcon,
    required this.warningColor,
    required this.warningBackground,
    this.recommended = false,
  });

  final String name;
  final String imageAsset;
  final String statusLabel;
  final IconData statusIcon;
  final Color statusColor;
  final Color statusBackground;
  final List<ComparisonMetric> metrics;
  final String warning;
  final IconData warningIcon;
  final Color warningColor;
  final Color warningBackground;
  final bool recommended;
}

const comparisonProducts = <ComparisonProduct>[
  ComparisonProduct(
    name: 'Kellogg’s\nCorn Flakes',
    imageAsset: AppAssets.productSearchKelloggs,
    statusLabel: 'Use with Caution',
    statusIcon: AppIcons.warning_amber_rounded,
    statusColor: AppColors.toneFFBE8300,
    statusBackground: AppColors.toneFFFFF6D9,
    warning: 'Added sugar may not be ideal for your diabetes profile.',
    warningIcon: AppIcons.warning_amber_rounded,
    warningColor: AppColors.toneFFBD7D00,
    warningBackground: AppColors.toneFFFFF6DD,
    metrics: <ComparisonMetric>[
      ComparisonMetric(
        label: 'Sugar',
        value: '8g',
        level: 'High',
        icon: AppIcons.view_in_ar_outlined,
        levelColor: AppColors.toneFFE14545,
      ),
      ComparisonMetric(
        label: 'Sodium',
        value: '180mg',
        level: 'High',
        icon: AppIcons.local_drink_outlined,
        levelColor: AppColors.warning,
      ),
      ComparisonMetric(
        label: 'Saturated Fat',
        value: '0g',
        level: 'Low',
        icon: AppIcons.water_drop_outlined,
        levelColor: AppColors.primary,
      ),
      ComparisonMetric(
        label: 'Calories',
        value: '120 kcal',
        level: 'Medium',
        icon: AppIcons.local_fire_department_outlined,
        levelColor: AppColors.warning,
      ),
    ],
  ),
  ComparisonProduct(
    name: 'Quaker Oats\nWholegrain Oats',
    imageAsset: AppAssets.productSearchQuaker,
    statusLabel: 'Looks Okay',
    statusIcon: AppIcons.check_circle_rounded,
    statusColor: AppColors.primaryDark,
    statusBackground: AppColors.successSurface,
    warning: 'Lower sugar and sodium. A better fit for your profile.',
    warningIcon: AppIcons.check_circle_rounded,
    warningColor: AppColors.primary,
    warningBackground: AppColors.successSurface,
    recommended: true,
    metrics: <ComparisonMetric>[
      ComparisonMetric(
        label: 'Sugar',
        value: '1g',
        level: 'Low',
        icon: AppIcons.view_in_ar_outlined,
        levelColor: AppColors.primary,
      ),
      ComparisonMetric(
        label: 'Sodium',
        value: '5mg',
        level: 'Low',
        icon: AppIcons.local_drink_outlined,
        levelColor: AppColors.primary,
      ),
      ComparisonMetric(
        label: 'Saturated Fat',
        value: '0.5g',
        level: 'Low',
        icon: AppIcons.water_drop_outlined,
        levelColor: AppColors.primary,
      ),
      ComparisonMetric(
        label: 'Calories',
        value: '110 kcal',
        level: 'Low',
        icon: AppIcons.local_fire_department_outlined,
        levelColor: AppColors.primary,
      ),
    ],
  ),
];

import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';


enum ProductDetailTab {
  overview,
  healthFlags,
  nutrition,
  ingredients,
  alternatives,
}

extension ProductDetailTabLabel on ProductDetailTab {
  String get label {
    switch (this) {
      case ProductDetailTab.overview:
        return 'Overview';
      case ProductDetailTab.healthFlags:
        return 'Health Flags';
      case ProductDetailTab.nutrition:
        return 'Nutrition';
      case ProductDetailTab.ingredients:
        return 'Ingredients';
      case ProductDetailTab.alternatives:
        return 'Alternatives';
    }
  }

  IconData get icon {
    switch (this) {
      case ProductDetailTab.overview:
        return AppIcons.description_outlined;
      case ProductDetailTab.healthFlags:
        return AppIcons.shield_outlined;
      case ProductDetailTab.nutrition:
        return AppIcons.restaurant_menu_outlined;
      case ProductDetailTab.ingredients:
        return AppIcons.eco_outlined;
      case ProductDetailTab.alternatives:
        return AppIcons.compare_arrows_rounded;
    }
  }
}

class ProductNutritionMetric {
  const ProductNutritionMetric({
    required this.label,
    required this.value,
    required this.level,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  final String label;
  final String value;
  final String level;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
}

class ProductHealthConcern {
  const ProductHealthConcern({
    required this.label,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  final String label;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
}

class HealthFlagInfo {
  const HealthFlagInfo({
    required this.title,
    required this.description,
    required this.metricLabel,
    required this.metricValue,
    required this.servingText,
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
  });

  final String title;
  final String description;
  final String metricLabel;
  final String metricValue;
  final String servingText;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final Color borderColor;
}

class IngredientFlagInfo {
  const IngredientFlagInfo({
    required this.title,
    required this.severity,
    required this.reason,
    required this.concern,
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
    required this.severityColor,
    required this.severityBackgroundColor,
  });

  final String title;
  final String severity;
  final String reason;
  final String concern;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final Color borderColor;
  final Color severityColor;
  final Color severityBackgroundColor;
}

class PersonalizedAlertInfo {
  const PersonalizedAlertInfo({
    required this.condition,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
    required this.badgeColor,
  });

  final String condition;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final Color borderColor;
  final Color badgeColor;
}

const laysProductName = 'Lay’s American Style Cream & Onion';
const laysBrandName = 'Lay’s';
const laysProductImage = AppAssets.productLays;
const laysLastVerified = 'May 18, 2025';

const overviewMetrics = <ProductNutritionMetric>[
  ProductNutritionMetric(
    label: 'Calories',
    value: '160',
    level: 'Per 28g serving',
    icon: AppIcons.local_fire_department_outlined,
    color: AppColors.amber,
    backgroundColor: AppColors.softAmber,
  ),
  ProductNutritionMetric(
    label: 'Sugar',
    value: '1g',
    level: 'Low',
    icon: AppIcons.inventory_2_outlined,
    color: AppColors.primary,
    backgroundColor: AppColors.softGreen,
  ),
  ProductNutritionMetric(
    label: 'Sodium',
    value: '200mg',
    level: 'High',
    icon: AppIcons.science_outlined,
    color: AppColors.dangerMuted,
    backgroundColor: AppColors.softRed,
  ),
  ProductNutritionMetric(
    label: 'Total Fat',
    value: '10g',
    level: 'High',
    icon: AppIcons.water_drop_outlined,
    color: AppColors.dangerMuted,
    backgroundColor: AppColors.softRed,
  ),
  ProductNutritionMetric(
    label: 'Saturated Fat',
    value: '1.5g',
    level: 'Medium',
    icon: AppIcons.water_drop_outlined,
    color: AppColors.amber,
    backgroundColor: AppColors.softAmber,
  ),
  ProductNutritionMetric(
    label: 'Trans Fat',
    value: '0g',
    level: 'Good',
    icon: AppIcons.water_drop_outlined,
    color: AppColors.toneFF313940,
    backgroundColor: AppColors.toneFFF6F8F7,
  ),
  ProductNutritionMetric(
    label: 'Protein',
    value: '2g',
    level: 'Low',
    icon: AppIcons.fitness_center_outlined,
    color: AppColors.primary,
    backgroundColor: AppColors.softGreen,
  ),
  ProductNutritionMetric(
    label: 'Fiber',
    value: '1g',
    level: 'Low',
    icon: AppIcons.eco_outlined,
    color: AppColors.primary,
    backgroundColor: AppColors.softGreen,
  ),
];

const topHealthConcerns = <ProductHealthConcern>[
  ProductHealthConcern(
    label: 'High Sodium',
    icon: AppIcons.science_outlined,
    color: AppColors.dangerStrong,
    backgroundColor: AppColors.dangerSurface,
  ),
  ProductHealthConcern(
    label: 'High in Fat',
    icon: AppIcons.water_drop,
    color: AppColors.dangerStrong,
    backgroundColor: AppColors.dangerSurface,
  ),
  ProductHealthConcern(
    label: 'Additives Present',
    icon: AppIcons.science_outlined,
    color: AppColors.amber,
    backgroundColor: AppColors.warningSurface,
  ),
  ProductHealthConcern(
    label: 'Low Fiber',
    icon: AppIcons.eco_outlined,
    color: AppColors.amber,
    backgroundColor: AppColors.warningSurface,
  ),
];

const redFlags = <HealthFlagInfo>[
  HealthFlagInfo(
    title: 'High Sugar',
    description: 'This product has high sugar. Better to avoid if you are managing blood sugar.',
    metricLabel: 'Sugar',
    metricValue: '18g',
    servingText: 'Per 28g serving',
    icon: AppIcons.view_in_ar_outlined,
    color: AppColors.danger,
    backgroundColor: AppColors.softRed,
    borderColor: AppColors.dangerBorder,
  ),
  HealthFlagInfo(
    title: 'High Sodium',
    description: 'This product has high sodium. Too much sodium may not be good for your heart.',
    metricLabel: 'Sodium',
    metricValue: '200mg',
    servingText: 'Per 28g serving',
    icon: AppIcons.science_outlined,
    color: AppColors.danger,
    backgroundColor: AppColors.softRed,
    borderColor: AppColors.dangerBorder,
  ),
];

const yellowFlags = <HealthFlagInfo>[
  HealthFlagInfo(
    title: 'Contains Additives',
    description: 'This product contains additives that some people prefer to limit.',
    metricLabel: 'Contains',
    metricValue: 'Monosodium Glutamate\n(INS 621), Artificial\nFlavour',
    servingText: '',
    icon: AppIcons.science_outlined,
    color: AppColors.amber,
    backgroundColor: AppColors.softAmber,
    borderColor: AppColors.warningBorder,
  ),
  HealthFlagInfo(
    title: 'Saturated Fat',
    description: 'Contains saturated fat. Try to keep intake low for heart health.',
    metricLabel: 'Saturated Fat',
    metricValue: '1.5g',
    servingText: 'Per 28g serving',
    icon: AppIcons.water_drop_outlined,
    color: AppColors.amber,
    backgroundColor: AppColors.softAmber,
    borderColor: AppColors.warningBorder,
  ),
];

const greenNotes = <HealthFlagInfo>[
  HealthFlagInfo(
    title: 'No Trans Fat',
    description: 'Good news! This product does not contain trans fat.',
    metricLabel: 'Trans Fat',
    metricValue: '0g',
    servingText: 'Per 28g serving',
    icon: AppIcons.eco,
    color: AppColors.primary,
    backgroundColor: AppColors.softGreen,
    borderColor: AppColors.successBorder,
  ),
  HealthFlagInfo(
    title: 'Contains Dietary Fiber',
    description: 'Provides a small amount of dietary fiber which supports digestion.',
    metricLabel: 'Dietary Fiber',
    metricValue: '1g',
    servingText: 'Per 28g serving',
    icon: AppIcons.eco_outlined,
    color: AppColors.primary,
    backgroundColor: AppColors.softGreen,
    borderColor: AppColors.successBorder,
  ),
];

const ingredientFlags = <IngredientFlagInfo>[
  IngredientFlagInfo(
    title: 'Monosodium Glutamate (INS 621)',
    severity: 'High',
    reason: 'Flavour enhancer used to improve taste.',
    concern: 'May cause headache or nausea in sensitive individuals.',
    icon: AppIcons.science,
    color: AppColors.danger,
    backgroundColor: AppColors.dangerSurface,
    borderColor: AppColors.toneFFFFD2D7,
    severityColor: AppColors.danger,
    severityBackgroundColor: AppColors.toneFFFFE9EC,
  ),
  IngredientFlagInfo(
    title: 'Citric Acid (INS 330)',
    severity: 'Medium',
    reason: 'Acidity regulator.',
    concern: 'May cause tooth enamel erosion if consumed in excess.',
    icon: AppIcons.water_drop_outlined,
    color: AppColors.amber,
    backgroundColor: AppColors.warningSurface,
    borderColor: AppColors.warningBorderStrong,
    severityColor: AppColors.warningAccent,
    severityBackgroundColor: AppColors.warningSurface,
  ),
  IngredientFlagInfo(
    title: 'Disodium Inosinate (INS 631)',
    severity: 'Medium',
    reason: 'Flavour enhancer.',
    concern: 'May cause mild sensitivities in some people.',
    icon: AppIcons.science_outlined,
    color: AppColors.amber,
    backgroundColor: AppColors.warningSurface,
    borderColor: AppColors.warningBorderStrong,
    severityColor: AppColors.warningAccent,
    severityBackgroundColor: AppColors.warningSurface,
  ),
  IngredientFlagInfo(
    title: 'Anticaking Agent (INS 551)',
    severity: 'Low',
    reason: 'Prevents clumping of powder.',
    concern: 'Generally recognized as safe in small amounts.',
    icon: AppIcons.shield_outlined,
    color: AppColors.primary,
    backgroundColor: AppColors.softGreenStrong,
    borderColor: AppColors.toneFFD3EFDE,
    severityColor: AppColors.primary,
    severityBackgroundColor: AppColors.softGreenStrong,
  ),
];

const personalizedAlerts = <PersonalizedAlertInfo>[
  PersonalizedAlertInfo(
    condition: 'Diabetes',
    title: 'Better to avoid',
    description: 'Contains high sugar / added sugar.',
    icon: AppIcons.warning_amber_rounded,
    color: AppColors.toneFFD43B4A,
    backgroundColor: AppColors.toneFFFFF5F6,
    borderColor: AppColors.toneFFFFC8D0,
    badgeColor: AppColors.toneFFFFE5E9,
  ),
  PersonalizedAlertInfo(
    condition: 'Kidney concern',
    title: 'Check before using',
    description: 'High sodium may not be suitable.',
    icon: AppIcons.warning_amber_rounded,
    color: AppColors.toneFFE2A111,
    backgroundColor: AppColors.toneFFFFFCF5,
    borderColor: AppColors.toneFFFFE5B4,
    badgeColor: AppColors.toneFFFFF2D5,
  ),
  PersonalizedAlertInfo(
    condition: 'High blood pressure',
    title: 'Use with caution',
    description: 'Sodium level is high.',
    icon: AppIcons.warning_amber_rounded,
    color: AppColors.primary,
    backgroundColor: AppColors.toneFFF7FEFA,
    borderColor: AppColors.toneFFCCEFE0,
    badgeColor: AppColors.toneFFE1F8EC,
  ),
];

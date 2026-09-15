import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import 'product_workflow_models.dart';

const productInformationSection = ExtractedSection(
  title: 'Product Information',
  icon: AppIcons.sell_outlined,
  fields: <ExtractedField>[
    ExtractedField(label: 'Product name', value: 'Oats & Honey Granola'),
    ExtractedField(label: 'Brand', value: "Nature's Goodness"),
    ExtractedField(label: 'Barcode', value: '8901234567890'),
    ExtractedField(
      label: 'Category',
      value: 'Breakfast Cereals',
      lowConfidence: true,
    ),
    ExtractedField(label: 'Net weight', value: '500 g'),
    ExtractedField(label: 'Country', value: 'India'),
    ExtractedField(
      label: 'Manufacturer',
      value: 'Healthy Life Foods Pvt. Ltd',
      lowConfidence: true,
    ),
  ],
);

const nutritionInformationSection = ExtractedSection(
  title: 'Nutrition Information',
  icon: AppIcons.eco_rounded,
  fields: <ExtractedField>[
    ExtractedField(label: 'Serving size', value: '40 g'),
    ExtractedField(label: 'Calories', value: '190 kcal'),
    ExtractedField(label: 'Sugar', value: '8 g'),
    ExtractedField(label: 'Added sugar', value: '5 g', lowConfidence: true),
    ExtractedField(label: 'Sodium', value: '210 mg', lowConfidence: true),
    ExtractedField(label: 'Total fat', value: '6 g'),
    ExtractedField(label: 'Saturated fat', value: '1 g'),
    ExtractedField(label: 'Protein', value: '5 g'),
    ExtractedField(label: 'Carbohydrate', value: '28 g'),
  ],
);

const extractedIngredients =
    'Whole grain oats (54%), honey (15%), brown rice crisps (rice, rice flour, sugar, salt), sunflower seeds, almond slices, raisins, canola oil, natural flavor, salt, cinnamon.';

const reviewHealthFlags = <HealthReviewFlag>[
  HealthReviewFlag(
    title: 'Added Sugar',
    description: 'Contains added sugar (1g per 28g).',
    value: 'Value: 1 g',
    level: 'High',
    icon: AppIcons.hub_outlined,
    color: AppColors.dangerAlt,
    background: AppColors.softRed,
  ),
  HealthReviewFlag(
    title: 'High Sodium',
    description: 'Sodium level is high.',
    value: 'Value: 200 mg',
    level: 'High',
    icon: AppIcons.local_drink_outlined,
    color: AppColors.dangerAlt,
    background: AppColors.softRed,
  ),
  HealthReviewFlag(
    title: 'Saturated Fat',
    description: 'Contains saturated fat.',
    value: 'Value: 1.5 g',
    level: 'Medium',
    icon: AppIcons.water_drop_outlined,
    color: AppColors.amber,
    background: AppColors.warningSurfaceMuted,
  ),
  HealthReviewFlag(
    title: 'Additives Present',
    description: 'Contains permitted additives.',
    value: 'INS 330, INS 331(iii), INS 621, INS 631, INS 627, INS 551',
    level: 'Low',
    icon: AppIcons.science_outlined,
    color: AppColors.primary,
    background: AppColors.toneFFF0FAF4,
  ),
];

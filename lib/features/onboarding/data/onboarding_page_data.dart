import 'package:food_nutrient_app/core/design_system/design_system.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.imageAsset,
    required this.title,
    required this.description,
  });

  final String imageAsset;
  final String title;
  final String description;
}

const onboardingPages = <OnboardingPageData>[
  OnboardingPageData(
    imageAsset: AppAssets.onboardingScan,
    title: 'Scan packaged products',
    description:
        'Scan barcode, nutrition label, and ingredients\nto quickly understand what is inside your food.',
  ),
  OnboardingPageData(
    imageAsset: AppAssets.onboardingFlags,
    title: 'Understand health flags',
    description:
        'See red, yellow, and green flags for sugar,\nsodium, fat, additives, allergens, and other\nconcern areas.',
  ),
  OnboardingPageData(
    imageAsset: AppAssets.onboardingPersonalized,
    title: 'Personalized for your health',
    description:
        'Select your health concerns to get personalized\nwarnings for diabetes, blood pressure, kidney,\nliver, asthma, allergy, and more.',
  ),
];

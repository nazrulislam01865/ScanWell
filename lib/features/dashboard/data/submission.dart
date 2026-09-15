import 'package:food_nutrient_app/core/design_system/design_system.dart';

enum SubmissionStatus { accepted, pending, rejected, needsChange }

class Submission {
  const Submission({
    required this.productName,
    required this.brand,
    required this.category,
    required this.date,
    required this.imageAsset,
    required this.status,
  });

  final String productName;
  final String brand;
  final String category;
  final String date;
  final String imageAsset;
  final SubmissionStatus status;
}

const recentSubmissions = <Submission>[
  Submission(
    productName: 'Lay’s American Style Cream & Onion',
    brand: 'Lay’s',
    category: 'Snacks',
    date: 'May 18, 2025',
    imageAsset: AppAssets.productLays,
    status: SubmissionStatus.accepted,
  ),
  Submission(
    productName: 'Quaker Oats Original',
    brand: 'Quaker',
    category: 'Breakfast Cereal',
    date: 'May 17, 2025',
    imageAsset: AppAssets.productQuaker,
    status: SubmissionStatus.pending,
  ),
  Submission(
    productName: 'Coca-Cola Original Taste',
    brand: 'Coca-Cola',
    category: 'Beverages',
    date: 'May 16, 2025',
    imageAsset: AppAssets.productCoke,
    status: SubmissionStatus.needsChange,
  ),
  Submission(
    productName: 'Maggi 2-Minute Noodles',
    brand: 'Maggi',
    category: 'Instant Noodles',
    date: 'May 15, 2025',
    imageAsset: AppAssets.productMaggi,
    status: SubmissionStatus.rejected,
  ),
  Submission(
    productName: 'Amul Taaza Toned Milk',
    brand: 'Amul',
    category: 'Dairy',
    date: 'May 14, 2025',
    imageAsset: AppAssets.productAmul,
    status: SubmissionStatus.accepted,
  ),
];

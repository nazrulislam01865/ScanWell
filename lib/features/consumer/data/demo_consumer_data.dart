import 'package:food_nutrient_app/core/design_system/design_system.dart';
import 'consumer_product.dart';

const recentScans = <ConsumerProduct>[
  ConsumerProduct(
    name: "Lay’s Classic Potato Chips",
    brand: "Lay's",
    imageAsset: AppAssets.productHomeLays,
    healthFlag: HealthFlag.highConcern,
    insight: 'High in sodium and saturated fat',
    scannedAt: 'Today, 9:20 AM',
  ),
  ConsumerProduct(
    name: 'Maggi Masala Noodles',
    brand: 'Maggi',
    imageAsset: AppAssets.productHomeMaggi,
    healthFlag: HealthFlag.useWithCaution,
    insight: 'High in sodium; low in fiber',
    scannedAt: 'Yesterday, 7:45 PM',
  ),
  ConsumerProduct(
    name: 'Fresh Milk Full Cream',
    brand: 'Fresh Dairy',
    imageAsset: AppAssets.productHomeMilk,
    healthFlag: HealthFlag.looksOkay,
    insight: 'A good source of calcium',
    scannedAt: 'Yesterday, 10:10 AM',
  ),
  ConsumerProduct(
    name: "Kellogg’s Corn Flakes",
    brand: "Kellogg’s",
    imageAsset: AppAssets.productHomeKelloggs,
    healthFlag: HealthFlag.useWithCaution,
    insight: 'Contains added sugar',
    scannedAt: 'May 18, 6:30 PM',
  ),
];

const searchableProducts = <ConsumerProduct>[
  ConsumerProduct(
    name: 'Quaker Oats Wholegrain Oats',
    brand: 'Quaker',
    imageAsset: AppAssets.productSearchQuaker,
    healthFlag: HealthFlag.looksOkay,
    insight: 'High in fiber and whole grains',
    adminVerified: true,
  ),
  ConsumerProduct(
    name: "Kellogg’s Corn Flakes",
    brand: "Kellogg’s",
    imageAsset: AppAssets.productSearchKelloggs,
    healthFlag: HealthFlag.useWithCaution,
    insight: 'Contains added sugar',
    adminVerified: true,
  ),
  ConsumerProduct(
    name: "Lay’s Chile Limón Chips",
    brand: "Lay’s",
    imageAsset: AppAssets.productSearchLays,
    healthFlag: HealthFlag.highConcern,
    insight: 'High in sodium and saturated fat',
  ),
  ConsumerProduct(
    name: 'Tropicana 100% Orange Juice',
    brand: 'Tropicana',
    imageAsset: AppAssets.productSearchTropicana,
    healthFlag: HealthFlag.looksOkay,
    insight: '100% juice, no added sugar',
    adminVerified: true,
  ),
  ConsumerProduct(
    name: 'Maggi 2-Minute Noodles',
    brand: 'Maggi',
    imageAsset: AppAssets.productSearchMaggi,
    healthFlag: HealthFlag.useWithCaution,
    insight: 'High in sodium; low in fiber',
  ),
];

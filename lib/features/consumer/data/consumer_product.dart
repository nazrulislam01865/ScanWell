enum HealthFlag {
  looksOkay,
  useWithCaution,
  highConcern,
}

class ConsumerProduct {
  const ConsumerProduct({
    required this.name,
    required this.brand,
    required this.imageAsset,
    required this.healthFlag,
    required this.insight,
    this.scannedAt,
    this.adminVerified = false,
  });

  final String name;
  final String brand;
  final String imageAsset;
  final HealthFlag healthFlag;
  final String insight;
  final String? scannedAt;
  final bool adminVerified;
}

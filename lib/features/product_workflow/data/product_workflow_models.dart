import 'package:flutter/material.dart';

class ExtractedField {
  const ExtractedField({
    required this.label,
    required this.value,
    this.lowConfidence = false,
  });

  final String label;
  final String value;
  final bool lowConfidence;

  ExtractedField copyWith({String? value}) {
    return ExtractedField(
      label: label,
      value: value ?? this.value,
      lowConfidence: lowConfidence,
    );
  }
}

class ExtractedSection {
  const ExtractedSection({
    required this.title,
    required this.icon,
    required this.fields,
  });

  final String title;
  final IconData icon;
  final List<ExtractedField> fields;
}

class HealthReviewFlag {
  const HealthReviewFlag({
    required this.title,
    required this.description,
    required this.value,
    required this.level,
    required this.icon,
    required this.color,
    required this.background,
  });

  final String title;
  final String description;
  final String value;
  final String level;
  final IconData icon;
  final Color color;
  final Color background;
}

enum AdminDecision { approve, reject, requestChanges, merge }

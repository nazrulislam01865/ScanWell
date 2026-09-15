import 'package:flutter/material.dart';

import '../layout/responsive_layout.dart';
import 'app_button.dart';

/// Backwards-compatible auth/main CTA wrapper.
///
/// New feature code should prefer [AppButton] directly. This wrapper remains so
/// existing auth/onboarding call sites keep their exact responsive dimensions.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);
    return AppButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      size: compact ? AppButtonSize.authCompact : AppButtonSize.auth,
    );
  }
}

import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.requiredField = false,
    this.textInputAction,
    super.key,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool requiredField;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: label, style: AppTextStyles.authFieldLabel),
              if (requiredField)
                const TextSpan(
                  text: ' *',
                  style: AppTextStyle(
                    color: AppColors.error,
                    fontWeight: AppTypography.weight600,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.v7),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          style: AppTextStyles.authInputText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.authInputHint,
            prefixIcon: prefixIcon == null
                ? null
                : Icon(
                    prefixIcon,
                    size: AppSizes.iconControl,
                    color: AppColors.toneFF858C96,
                  ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

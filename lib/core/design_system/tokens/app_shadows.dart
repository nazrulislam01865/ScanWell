import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Named elevation recipes copied exactly from the pre-refactor UI.
abstract final class AppShadows {
  AppShadows._();

  static const topBar = [BoxShadow(color: AppColors.tone12000000, blurRadius: 9, offset: Offset(0, 3))];
  static const softCard = [BoxShadow(color: AppColors.tone08000000, blurRadius: 8, offset: Offset(0, 2))];
  static const duplicateCard = [BoxShadow(color: AppColors.tone0B000000, blurRadius: 12, offset: Offset(0, 3))];
  static const searchCard = [BoxShadow(color: AppColors.tone0B000000, blurRadius: 7, offset: Offset(0, 2))];
  static const bottomBar = [BoxShadow(color: AppColors.tone0A000000, blurRadius: 8, offset: Offset(0, -2))];
  static const scanAction = [BoxShadow(color: AppColors.tone29079447, blurRadius: 18, offset: Offset(0, 7))];
  static const softRaised = [BoxShadow(color: AppColors.tone0A000000, blurRadius: 8, offset: Offset(0, 2))];
  static const cameraInstructionText = [Shadow(color: AppColors.black38, blurRadius: 8, offset: Offset(0, 2))];
  static const subtleCard = [BoxShadow(color: AppColors.tone08000000, blurRadius: 7, offset: Offset(0, 2))];
}

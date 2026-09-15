import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../core/widgets/app_button.dart';
import 'package:flutter/services.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';

class ReviewPhotoScreen extends StatefulWidget {
  const ReviewPhotoScreen({super.key});

  @override
  State<ReviewPhotoScreen> createState() => _ReviewPhotoScreenState();
}

class _ReviewPhotoScreenState extends State<ReviewPhotoScreen> {
  bool _flashEnabled = false;
  _PhotoMode _selectedMode = _PhotoMode.barcode;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.cameraBackground,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).height < 740;

    return Scaffold(
      backgroundColor: AppColors.cameraBackground,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              AppColors.cameraBackground,
              AppColors.toneFF100D09,
              AppColors.toneFF080706,
            ],
          ),
        ),
        child: SafeArea(
          child: ResponsiveContent(
            maxWidth: AppSizes.contentComfortable,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final imageHeight = (constraints.maxHeight * (compact ? 0.46 : 0.49))
                    .clamp(310.0, 485.0)
                    .toDouble();

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.xxl,
                    compact ? AppSpacing.v10 : AppSpacing.v14,
                    AppSpacing.xxl,
                    AppSpacing.xl,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - AppSizes.v34,
                    ),
                    child: Column(
                      children: [
                        _PhotoTopBar(
                          flashEnabled: _flashEnabled,
                          onBack: () => Navigator.maybePop(context),
                          onFlashTap: () => setState(
                            () => _flashEnabled = !_flashEnabled,
                          ),
                        ),
                        SizedBox(height: compact ? AppSizes.v18 : AppSizes.v26),
                        Text(
                          'Review your photo',
                          style: AppTextStyles.pageTitleFor(
                            compact: compact,
                            variant: AppPageTitleVariant.reviewOnDark,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: AppSizes.v9),
                        Text(
                          'Make sure the label is clear before continuing',
                          textAlign: TextAlign.center,
                          style: AppTextStyle(
                            color: AppColors.white.withOpacity(AppOpacity.v0_68),
                            fontSize: compact ? AppTypography.font14 : AppTypography.font16,
                          ),
                        ),
                        SizedBox(height: compact ? AppSizes.v22 : AppSizes.v30),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadii.xxl),
                          child: SizedBox(
                            width: double.infinity,
                            height: imageHeight,
                            child: Image.asset(
                              AppAssets.reviewPhotoBarcodeWorkflow,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: compact ? AppSizes.v15 : AppSizes.v19),
                        _PhotoModeSelector(
                          selectedMode: _selectedMode,
                          onSelected: (mode) => setState(
                            () => _selectedMode = mode,
                          ),
                        ),
                        SizedBox(height: compact ? AppSizes.v24 : AppSizes.v34),
                        Row(
                          children: [
                            Expanded(
                              child: _ReviewPhotoButton(
                                label: 'Retake',
                                icon: AppIcons.refresh_rounded,
                                filled: false,
                                onPressed: () => Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.productCamera,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSizes.v14),
                            Expanded(
                              child: _ReviewPhotoButton(
                                label: 'Use Photo',
                                icon: AppIcons.check_circle_outline_rounded,
                                filled: true,
                                onPressed: () => Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.processingProduct,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.v18),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppButton(
                            label: 'View in Gallery',
                            icon: AppIcons.photo_library_outlined,
                            variant: AppButtonVariant.inverseText,
                            size: AppButtonSize.gallery,
                            emphasis: AppButtonEmphasis.standard,
                            fullWidth: false,
                            onPressed: () => _showMessage(
                              'Gallery picker is ready for integration.',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PhotoTopBar extends StatelessWidget {
  const _PhotoTopBar({
    required this.flashEnabled,
    required this.onBack,
    required this.onFlashTap,
  });

  final bool flashEnabled;
  final VoidCallback onBack;
  final VoidCallback onFlashTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBack,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: AppSizes.v44, height: AppSizes.v44),
          icon: const Icon(
            AppIcons.arrow_back_rounded,
            color: AppColors.white,
            size: AppSizes.iconFeatureLarge,
          ),
        ),
        const Spacer(),
        Material(
          color: AppColors.toneFF262626,
          borderRadius: BorderRadius.circular(AppRadii.xxl),
          child: InkWell(
            onTap: onFlashTap,
            borderRadius: BorderRadius.circular(AppRadii.xxl),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.v13),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    flashEnabled ? AppIcons.flash_on_rounded : AppIcons.flash_off_rounded,
                    color: AppColors.white,
                    size: AppSizes.iconLg,
                  ),
                  const SizedBox(width: AppSizes.v7),
                  Text(
                    flashEnabled ? 'On' : 'Off',
                    style: const AppTextStyle(
                      color: AppColors.white,
                      fontSize: AppTypography.font15,
                      fontWeight: AppTypography.weight600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum _PhotoMode { barcode, frontPack, nutritionLabel, ingredients }

extension on _PhotoMode {
  String get label {
    switch (this) {
      case _PhotoMode.barcode:
        return 'Barcode';
      case _PhotoMode.frontPack:
        return 'Front Pack';
      case _PhotoMode.nutritionLabel:
        return 'Nutrition Label';
      case _PhotoMode.ingredients:
        return 'Ingredients';
    }
  }

  IconData get icon {
    switch (this) {
      case _PhotoMode.barcode:
        return AppIcons.qr_code_2_rounded;
      case _PhotoMode.frontPack:
        return AppIcons.inventory_2_outlined;
      case _PhotoMode.nutritionLabel:
        return AppIcons.receipt_long_outlined;
      case _PhotoMode.ingredients:
        return AppIcons.eco_outlined;
    }
  }
}

class _PhotoModeSelector extends StatelessWidget {
  const _PhotoModeSelector({
    required this.selectedMode,
    required this.onSelected,
  });

  final _PhotoMode selectedMode;
  final ValueChanged<_PhotoMode> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: _PhotoMode.values
            .map(
              (mode) => Padding(
                padding: EdgeInsets.only(
                  right: mode == _PhotoMode.values.last ? AppSpacing.none : AppSpacing.v9,
                ),
                child: _PhotoModeChip(
                  mode: mode,
                  selected: mode == selectedMode,
                  onTap: () => onSelected(mode),
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _PhotoModeChip extends StatelessWidget {
  const _PhotoModeChip({
    required this.mode,
    required this.selected,
    required this.onTap,
  });

  final _PhotoMode mode;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.success : AppColors.toneFF242321,
      borderRadius: BorderRadius.circular(AppRadii.xxl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.xxl),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v13, vertical: AppSpacing.v10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.xxl),
            border: Border.all(
              color: selected ? AppColors.success : AppColors.white24,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(mode.icon, color: AppColors.white, size: AppSizes.iconCompact),
              const SizedBox(width: AppSizes.v7),
              Text(
                mode.label,
                style: const AppTextStyle(
                  color: AppColors.white,
                  fontSize: AppTypography.font12,
                  fontWeight: AppTypography.weight500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewPhotoButton extends StatelessWidget {
  const _ReviewPhotoButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: label,
      icon: icon,
      variant: filled
          ? AppButtonVariant.cameraPrimary
          : AppButtonVariant.cameraOutline,
      size: AppButtonSize.camera,
      emphasis: AppButtonEmphasis.standard,
      onPressed: onPressed,
    );
  }
}

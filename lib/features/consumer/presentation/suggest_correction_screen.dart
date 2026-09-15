import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/primary_button.dart';

class SuggestCorrectionScreen extends StatefulWidget {
  const SuggestCorrectionScreen({super.key});

  @override
  State<SuggestCorrectionScreen> createState() =>
      _SuggestCorrectionScreenState();
}

class _SuggestCorrectionScreenState extends State<SuggestCorrectionScreen> {
  final TextEditingController _commentController = TextEditingController();
  _CorrectionType? _selectedType;
  String? _uploadedPhotoName;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _selectPhoto() {
    setState(() => _uploadedPhotoName = 'correction_photo.jpg');
  }

  void _submit() {
    if (_selectedType == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Select what needs correction.')),
        );
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Correction submitted for review.'),
        ),
      );
    Navigator.maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ResponsiveContent(
          maxWidth: AppSizes.contentMedium,
          child: Column(
            children: [
              _CorrectionAppBar(onBack: () => Navigator.maybePop(context)),
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    compact ? AppSpacing.lg : AppSpacing.xxl,
                    AppSpacing.v7,
                    compact ? AppSpacing.lg : AppSpacing.xxl,
                    AppSpacing.xxl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _CorrectionProductCard(),
                      const SizedBox(height: AppSizes.v15),
                      const Text(
                        'What needs correction?',
                        style: AppTextStyle(
                          fontSize: AppTypography.font17,
                          fontWeight: AppTypography.weight800,
                        ),
                      ),
                      const SizedBox(height: AppSizes.v8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadii.lg),
                          border: Border.all(color: AppColors.border),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: List.generate(
                            _CorrectionType.values.length,
                            (index) => _CorrectionOptionRow(
                              type: _CorrectionType.values[index],
                              selected:
                                  _selectedType == _CorrectionType.values[index],
                              showDivider:
                                  index != _CorrectionType.values.length - 1,
                              onTap: () => setState(
                                () => _selectedType = _CorrectionType.values[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.v15),
                      const Text(
                        'Upload photo (optional)',
                        style: AppTextStyle(
                          fontSize: AppTypography.font14,
                          fontWeight: AppTypography.weight600,
                        ),
                      ),
                      const SizedBox(height: AppSizes.v8),
                      _UploadPhotoBox(
                        fileName: _uploadedPhotoName,
                        onTap: _selectPhoto,
                      ),
                      const SizedBox(height: AppSizes.v15),
                      const Text(
                        'Additional comments (optional)',
                        style: AppTextStyle(
                          fontSize: AppTypography.font14,
                          fontWeight: AppTypography.weight600,
                        ),
                      ),
                      const SizedBox(height: AppSizes.v8),
                      TextField(
                        controller: _commentController,
                        maxLength: 500,
                        minLines: 3,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Please describe the correction in detail...',
                          hintStyle: const AppTextStyle(fontSize: AppTypography.font13),
                          contentPadding: const EdgeInsets.all(AppSpacing.v13),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadii.card),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadii.card),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: AppSizes.v1_3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.v9),
                      const _ReviewNotice(),
                      const SizedBox(height: AppSizes.v13),
                      PrimaryButton(
                        label: 'Submit Correction',
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CorrectionAppBar extends StatelessWidget {
  const _CorrectionAppBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.v60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(
                AppIcons.arrow_back_ios_new_rounded,
                color: AppColors.primary,
                size: AppSizes.iconLg,
              ),
            ),
          ),
          const Text(
            'Suggest a correction',
            style: AppTextStyle(
              fontSize: AppTypography.font21,
              fontWeight: AppTypography.weight800,
              letterSpacing: AppTypography.letterSpacingn0_3,
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: AppSpacing.v15),
              child: Icon(
                AppIcons.health_and_safety_rounded,
                color: AppColors.primary,
                size: AppSizes.iconHero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CorrectionProductCard extends StatelessWidget {
  const _CorrectionProductCard();

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadii.v15),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.sm),
            child: Image.asset(
              AppAssets.correctionGranolaWorkflow,
              width: compact ? AppSizes.v112 : AppSizes.v142,
              height: compact ? AppSizes.v132 : AppSizes.v160,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: compact ? AppSizes.v13 : AppSizes.v18),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nature's Path Organic\nPumpkin Seed + Flax Granola",
                  style: AppTextStyle(
                    fontSize: AppTypography.font17,
                    height: AppTypography.lineHeight1_15,
                    fontWeight: AppTypography.weight800,
                  ),
                ),
                SizedBox(height: AppSizes.v13),
                _ProductDetailLine(label: 'Brand:', value: "Nature's Path"),
                _ProductDetailLine(label: 'Size:', value: '11 oz (312 g)'),
                _ProductDetailLine(
                  label: 'Category:',
                  value: 'Breakfast & Cereal',
                ),
                _ProductDetailLine(
                  label: 'Barcode:',
                  value: '058449123456',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductDetailLine extends StatelessWidget {
  const _ProductDetailLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.v5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSizes.v65,
            child: Text(
              label,
              style: const AppTextStyle(
                color: AppColors.textSecondary,
                fontSize: AppTypography.font11_5,
                fontWeight: AppTypography.weight600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const AppTextStyle(fontSize: AppTypography.font11_5, height: AppTypography.lineHeight1_25),
            ),
          ),
        ],
      ),
    );
  }
}

enum _CorrectionType {
  productName,
  nutritionInfo,
  ingredients,
  healthFlag,
  duplicateProduct,
  outdatedLabel,
  other,
}

extension on _CorrectionType {
  String get label {
    switch (this) {
      case _CorrectionType.productName:
        return 'Wrong product name';
      case _CorrectionType.nutritionInfo:
        return 'Wrong nutrition info';
      case _CorrectionType.ingredients:
        return 'Wrong ingredients';
      case _CorrectionType.healthFlag:
        return 'Wrong health flag';
      case _CorrectionType.duplicateProduct:
        return 'Duplicate product';
      case _CorrectionType.outdatedLabel:
        return 'Outdated label';
      case _CorrectionType.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case _CorrectionType.productName:
        return AppIcons.sell_outlined;
      case _CorrectionType.nutritionInfo:
        return AppIcons.pie_chart_outline_rounded;
      case _CorrectionType.ingredients:
        return AppIcons.eco_outlined;
      case _CorrectionType.healthFlag:
        return AppIcons.flag_outlined;
      case _CorrectionType.duplicateProduct:
        return AppIcons.copy_all_outlined;
      case _CorrectionType.outdatedLabel:
        return AppIcons.calendar_month_outlined;
      case _CorrectionType.other:
        return AppIcons.more_horiz_rounded;
    }
  }
}

class _CorrectionOptionRow extends StatelessWidget {
  const _CorrectionOptionRow({
    required this.type,
    required this.selected,
    required this.showDivider,
    required this.onTap,
  });

  final _CorrectionType type;
  final bool selected;
  final bool showDivider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.softGreen : AppColors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: AppSizes.v49,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v13, vertical: AppSpacing.sm),
          decoration: showDivider
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.divider),
                  ),
                )
              : null,
          child: Row(
            children: [
              Icon(type.icon, color: AppColors.primaryDark, size: AppSizes.iconControl),
              const SizedBox(width: AppSizes.v12),
              Expanded(
                child: Text(
                  type.label,
                  style: const AppTextStyle(
                    fontSize: AppTypography.font14,
                    fontWeight: AppTypography.weight500,
                  ),
                ),
              ),
              Container(
                width: AppSizes.v22,
                height: AppSizes.v22,
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: AppSizes.v1_5),
                ),
                child: selected
                    ? const Icon(AppIcons.check_rounded, color: AppColors.white, size: AppSizes.iconSm)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UploadPhotoBox extends StatelessWidget {
  const _UploadPhotoBox({required this.fileName, required this.onTap});

  final String? fileName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: AppColors.toneFFCFD9D1,
        radius: 11,
      ),
      child: Material(
        color: AppColors.toneFFFBFDFC,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.card),
          child: SizedBox(
            width: double.infinity,
            height: AppSizes.v86,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      AppIcons.cloud_upload_outlined,
                      color: AppColors.primary,
                      size: AppSizes.iconFeature,
                    ),
                    const SizedBox(width: AppSizes.v9),
                    Text(
                      fileName ?? 'Upload photo',
                      style: const AppTextStyle(
                        color: AppColors.primaryDark,
                        fontSize: AppTypography.font15,
                        fontWeight: AppTypography.weight700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.v5),
                Text(
                  fileName == null ? 'Tap to choose an image' : 'Tap to replace image',
                  style: const AppTextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTypography.font11_5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewNotice extends StatelessWidget {
  const _ReviewNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v14, vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.softGreen,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.toneFFDDEEE3),
      ),
      child: const Row(
        children: [
          Icon(AppIcons.shield_outlined, color: AppColors.primary, size: AppSizes.iconHeroLarge),
          SizedBox(width: AppSizes.v12),
          Expanded(
            child: Text(
              'Our review team will check your suggestion before updating the database.',
              style: AppTextStyle(
                color: AppColors.toneFF285B36,
                fontSize: AppTypography.font12_5,
                height: AppTypography.lineHeight1_3,
                fontWeight: AppTypography.weight500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(radius),
        ),
      );
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    const dash = 6.0;
    const gap = 4.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dash),
          paint,
        );
        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}

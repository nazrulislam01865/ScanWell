import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../core/widgets/app_button.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';

class PossibleDuplicateScreen extends StatelessWidget {
  const PossibleDuplicateScreen({super.key});

  void _continueToExtractedData(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.reviewExtractedData);
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveContent(
          maxWidth: AppSizes.contentMedium,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    compact ? AppSpacing.lg : AppSpacing.xxl,
                    AppSpacing.v6,
                    compact ? AppSpacing.lg : AppSpacing.xxl,
                    AppSpacing.v18,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          key: const Key('duplicate-back'),
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(
                            AppIcons.arrow_back_rounded,
                            color: AppColors.primaryDark,
                            size: AppSizes.iconHero,
                          ),
                        ),
                      ),
                      _WarningMark(compact: compact),
                      SizedBox(height: compact ? AppSizes.v10 : AppSizes.v13),
                      Text(
                        'Possible duplicate found',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.pageTitleFor(
                          compact: compact,
                          variant: AppPageTitleVariant.tight,
                        ),
                      ),
                      const SizedBox(height: AppSizes.v9),
                      Text(
                        'This product may already exist in the database.',
                        textAlign: TextAlign.center,
                        style: AppTextStyle(
                          color: AppColors.textSecondary,
                          fontSize: compact ? AppTypography.font13_5 : AppTypography.font15,
                        ),
                      ),
                      SizedBox(height: compact ? AppSizes.v18 : AppSizes.v23),
                      const _ReviewNotice(),
                      const SizedBox(height: AppSizes.v15),
                      const _DuplicateCard(
                        title: 'Existing product',
                        icon: AppIcons.storage_rounded,
                        rows: [
                          _DuplicateRowData(
                            icon: AppIcons.sell_outlined,
                            label: 'Product name',
                            value: 'Oats & Honey Granola',
                          ),
                          _DuplicateRowData(
                            icon: AppIcons.apartment_outlined,
                            label: 'Brand',
                            value: 'Nature’s Goodness',
                          ),
                          _DuplicateRowData(
                            icon: AppIcons.qr_code_2_rounded,
                            label: 'Barcode',
                            value: '8901234567890',
                          ),
                          _DuplicateRowData(
                            icon: AppIcons.calendar_month_outlined,
                            label: 'Last updated',
                            value: 'Updated on May 12, 2026',
                          ),
                        ],
                        footerLabel: 'Current health flag status',
                        footerValue: 'Use with Caution',
                        footerIcon: AppIcons.error_outline_rounded,
                        footerAmber: true,
                      ),
                      const SizedBox(height: AppSizes.v13),
                      const _DuplicateCard(
                        title: 'Your submission',
                        icon: AppIcons.edit_outlined,
                        rows: [
                          _DuplicateRowData(
                            icon: AppIcons.sell_outlined,
                            label: 'Extracted product name',
                            value: 'Oats & Honey Granola',
                          ),
                          _DuplicateRowData(
                            icon: AppIcons.qr_code_2_rounded,
                            label: 'Barcode',
                            value: '8901234567890',
                          ),
                          _DuplicateRowData(
                            icon: AppIcons.sync_alt_rounded,
                            label: 'Changed fields',
                            value: '3 fields changed',
                            valueGreen: true,
                          ),
                        ],
                        note:
                            'Nutrition updated  •  Manufacturer changed  •\nPackaging updated',
                      ),
                      const SizedBox(height: AppSizes.v17),
                      _PrimaryDuplicateButton(
                        label: 'Compare Details',
                        icon: AppIcons.balance_outlined,
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'The existing product and your changed fields are shown above.',
                                ),
                              ),
                            );
                        },
                      ),
                      const SizedBox(height: AppSizes.v9),
                      _OutlinedDuplicateButton(
                        label: 'Submit as Update',
                        icon: AppIcons.edit_outlined,
                        amber: true,
                        onPressed: () => _continueToExtractedData(context),
                      ),
                      const SizedBox(height: AppSizes.v9),
                      _OutlinedDuplicateButton(
                        label: 'This is a Different Product',
                        icon: AppIcons.view_in_ar_outlined,
                        onPressed: () => _continueToExtractedData(context),
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

class _WarningMark extends StatelessWidget {
  const _WarningMark({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: compact ? AppSizes.v63 : AppSizes.v70,
      height: compact ? AppSizes.v63 : AppSizes.v70,
      decoration: const BoxDecoration(
        color: AppColors.toneFFFFF9E7,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        AppIcons.warning_amber_rounded,
        color: AppColors.toneFFE1A41D,
        size: AppSizes.iconDisplayXLarge,
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v17, vertical: AppSpacing.v14),
      decoration: BoxDecoration(
        color: AppColors.toneFFFFF9E9,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: AppColors.toneFFF4D982),
      ),
      child: const Row(
        children: [
          Icon(
            AppIcons.warning_amber_rounded,
            color: AppColors.toneFFBE8610,
            size: AppSizes.iconFeatureLarge,
          ),
          SizedBox(width: AppSizes.v13),
          Expanded(
            child: Text(
              'Please review the details before submitting.',
              style: AppTextStyle(
                fontSize: AppTypography.font14_5,
                height: AppTypography.lineHeight1_25,
                fontWeight: AppTypography.weight500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DuplicateCard extends StatelessWidget {
  const _DuplicateCard({
    required this.title,
    required this.icon,
    required this.rows,
    this.footerLabel,
    this.footerValue,
    this.footerIcon,
    this.footerAmber = false,
    this.note,
  });

  final String title;
  final IconData icon;
  final List<_DuplicateRowData> rows;
  final String? footerLabel;
  final String? footerValue;
  final IconData? footerIcon;
  final bool footerAmber;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        compact ? AppSpacing.md : AppSpacing.v15,
        AppSpacing.v13,
        compact ? AppSpacing.md : AppSpacing.v15,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadii.v13),
        border: Border.all(color: AppColors.toneFFE4E7E5),
        boxShadow: AppShadows.duplicateCard,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryDark, size: AppSizes.iconActionLarge),
              const SizedBox(width: AppSizes.v10),
              Text(
                title,
                style: const AppTextStyle(
                  color: AppColors.primaryDark,
                  fontSize: AppTypography.font18,
                  fontWeight: AppTypography.weight800,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.v10),
          const Divider(height: AppSizes.v1, color: AppColors.divider),
          const SizedBox(height: AppSizes.v11),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadii.v7),
                child: Image.asset(
                  AppAssets.granolaExtractedWorkflow,
                  width: compact ? AppSizes.v92 : AppSizes.v108,
                  height: compact ? AppSizes.v126 : AppSizes.v145,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: AppSizes.v13),
              Expanded(
                child: Column(
                  children: List.generate(
                    rows.length,
                    (index) => _DuplicateRow(
                      data: rows[index],
                      showDivider: index != rows.length - 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (note != null) ...[
            const SizedBox(height: AppSizes.v11),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.v10),
              decoration: BoxDecoration(
                color: AppColors.warningSurfaceSubtle,
                borderRadius: BorderRadius.circular(AppRadii.sm),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    AppIcons.info_outline_rounded,
                    color: AppColors.toneFFB78313,
                    size: AppSizes.iconControlTight,
                  ),
                  const SizedBox(width: AppSizes.v8),
                  Expanded(
                    child: Text(
                      note!,
                      style: const AppTextStyle(
                        color: AppColors.toneFF5E6165,
                        fontSize: AppTypography.font12,
                        height: AppTypography.lineHeight1_35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (footerLabel != null && footerValue != null) ...[
            const SizedBox(height: AppSizes.v12),
            const Divider(height: AppSizes.v1, color: AppColors.divider),
            const SizedBox(height: AppSizes.v11),
            Row(
              children: [
                Expanded(
                  child: Text(
                    footerLabel!,
                    style: const AppTextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppTypography.font13,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v13, vertical: AppSpacing.v7),
                  decoration: BoxDecoration(
                    color: footerAmber
                        ? AppColors.warningSurfaceSubtle
                        : AppColors.softGreen,
                    borderRadius: BorderRadius.circular(AppRadii.chip),
                    border: Border.all(
                      color: footerAmber
                          ? AppColors.toneFFE8B633
                          : AppColors.primary,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        footerIcon ?? AppIcons.info_outline_rounded,
                        color: footerAmber
                            ? AppColors.toneFFBB8511
                            : AppColors.primary,
                        size: AppSizes.iconMd,
                      ),
                      const SizedBox(width: AppSizes.v7),
                      Text(
                        footerValue!,
                        style: AppTextStyle(
                          color: footerAmber
                              ? AppColors.toneFFA97910
                              : AppColors.primary,
                          fontSize: AppTypography.font13_5,
                          fontWeight: AppTypography.weight700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _DuplicateRow extends StatelessWidget {
  const _DuplicateRow({required this.data, required this.showDivider});

  final _DuplicateRowData data;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Container(
      constraints: const BoxConstraints(minHeight: AppSizes.v34),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.v6),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(
                bottom: BorderSide(color: AppColors.divider),
              )
            : null,
      ),
      child: Row(
        children: [
          Icon(data.icon, color: AppColors.primaryDark, size: AppSizes.iconCompact),
          const SizedBox(width: AppSizes.v8),
          Expanded(
            flex: 5,
            child: Text(
              data.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle(
                color: AppColors.textSecondary,
                fontSize: compact ? AppTypography.font10_5 : AppTypography.font11_5,
                height: AppTypography.lineHeight1_2,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.v6),
          Expanded(
            flex: 7,
            child: Text(
              data.value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: AppTextStyle(
                color: data.valueGreen
                    ? AppColors.primaryDark
                    : AppColors.textPrimary,
                fontSize: compact ? AppTypography.font11_5 : AppTypography.font12_5,
                height: AppTypography.lineHeight1_2,
                fontWeight: data.valueGreen ? AppTypography.weight700 : AppTypography.weight500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DuplicateRowData {
  const _DuplicateRowData({
    required this.icon,
    required this.label,
    required this.value,
    this.valueGreen = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool valueGreen;
}

class _PrimaryDuplicateButton extends StatelessWidget {
  const _PrimaryDuplicateButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: label,
      icon: icon,
      variant: AppButtonVariant.success,
      size: AppButtonSize.extraLarge,
      onPressed: onPressed,
    );
  }
}

class _OutlinedDuplicateButton extends StatelessWidget {
  const _OutlinedDuplicateButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.amber = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool amber;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: label,
      icon: icon,
      variant: amber
          ? AppButtonVariant.warningOutline
          : AppButtonVariant.duplicateOutline,
      size: AppButtonSize.review,
      fitLabel: true,
      onPressed: onPressed,
    );
  }
}

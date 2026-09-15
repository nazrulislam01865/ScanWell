import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../core/widgets/app_button.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/main_bottom_navigation.dart';
import '../data/product_comparison_data.dart';

class CompareProductsScreen extends StatelessWidget {
  const CompareProductsScreen({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Scaffold(
      bottomNavigationBar: const MainBottomNavigation(
        currentDestination: MainNavigationDestination.scan,
      ),
      body: SafeArea(
        bottom: false,
        child: ResponsiveContent(
          maxWidth: AppSizes.contentStandard,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              compact ? AppSpacing.v13 : AppSpacing.xl,
              AppSpacing.v10,
              compact ? AppSpacing.v13 : AppSpacing.xl,
              AppSpacing.v18,
            ),
            child: Column(
              children: [
                _CompareHeader(onBack: () => Navigator.maybePop(context)),
                const SizedBox(height: AppSizes.v5),
                Text(
                  'See which option fits you better.',
                  style: AppTextStyle(
                    color: AppColors.textSecondary,
                    fontSize: compact ? AppTypography.font14 : AppTypography.font16,
                  ),
                ),
                SizedBox(height: compact ? AppSizes.v43 : AppSizes.v50),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _ComparisonProductCard(
                        product: comparisonProducts[0],
                      ),
                    ),
                    const SizedBox(width: AppSizes.v11),
                    Expanded(
                      child: _ComparisonProductCard(
                        product: comparisonProducts[1],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.v17),
                AppButton(
                  label: 'View Full Details',
                  icon: AppIcons.search_rounded,
                  variant: AppButtonVariant.primaryRounded,
                  size: AppButtonSize.prominent,
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoutes.productDetail,
                  ),
                ),
                const SizedBox(height: AppSizes.v12),
                AppButton(
                  label: 'Compare Another Product',
                  icon: AppIcons.compare_arrows_rounded,
                  variant: AppButtonVariant.outlineRounded,
                  size: AppButtonSize.large,
                  onPressed: () => _showMessage(
                    context,
                    'Choose two more products to compare.',
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

class _CompareHeader extends StatelessWidget {
  const _CompareHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return SizedBox(
      height: AppSizes.v52,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: onBack,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: AppSizes.v44, height: AppSizes.v44),
              icon: const Icon(
                AppIcons.arrow_back_rounded,
                color: AppColors.primary,
                size: AppSizes.iconHero,
              ),
            ),
          ),
          Text(
            'Compare Products',
            style: AppTextStyles.pageTitleFor(
              compact: compact,
              variant: AppPageTitleVariant.comparison,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonProductCard extends StatelessWidget {
  const _ComparisonProductCard({required this.product});

  final ComparisonProduct product;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
            compact ? AppSpacing.sm : AppSpacing.v11,
            compact ? AppSpacing.v14 : AppSpacing.v17,
            compact ? AppSpacing.sm : AppSpacing.v11,
            AppSpacing.v11,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadii.v15),
            border: Border.all(
              color: product.recommended
                  ? AppColors.toneFF73C77A
                  : AppColors.border,
              width: product.recommended ? AppSizes.v1_2 : AppSizes.v1,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: compact ? AppSizes.v170 : AppSizes.v195,
                child: Image.asset(product.imageAsset, fit: BoxFit.contain),
              ),
              const SizedBox(height: AppSizes.v5),
              Text(
                product.name,
                textAlign: TextAlign.center,
                style: AppTextStyle(
                  fontSize: compact ? AppTypography.font14 : AppTypography.font16,
                  height: AppTypography.lineHeight1_12,
                  fontWeight: AppTypography.weight800,
                ),
              ),
              const SizedBox(height: AppSizes.v10),
              _ComparisonStatus(product: product),
              const SizedBox(height: AppSizes.v12),
              ...List.generate(
                product.metrics.length,
                (index) => _MetricRow(
                  metric: product.metrics[index],
                  showDivider: index != product.metrics.length - 1,
                ),
              ),
              const SizedBox(height: AppSizes.v11),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Personalized Warning',
                  style: AppTextStyle(fontSize: AppTypography.font11, fontWeight: AppTypography.weight800),
                ),
              ),
              const SizedBox(height: AppSizes.v7),
              _WarningBox(product: product),
            ],
          ),
        ),
        if (product.recommended)
          Positioned(
            top: AppSpacing.n35,
            right: -1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v10, vertical: AppSpacing.sm),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadii.md),
                  topRight: Radius.circular(AppRadii.md),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(AppIcons.check_circle_rounded, color: AppColors.white, size: AppSizes.iconFine),
                  SizedBox(width: AppSizes.v6),
                  Text(
                    'Better choice for your profile',
                    style: AppTextStyle(
                      color: AppColors.white,
                      fontSize: AppTypography.font10_5,
                      fontWeight: AppTypography.weight700,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ComparisonStatus extends StatelessWidget {
  const _ComparisonStatus({required this.product});

  final ComparisonProduct product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.v7),
      decoration: BoxDecoration(
        color: product.statusBackground,
        borderRadius: BorderRadius.circular(AppRadii.chip),
        border: Border.all(color: product.statusColor.withOpacity(AppOpacity.v0_24)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(product.statusIcon, color: product.statusColor, size: AppSizes.iconMediumTight),
          const SizedBox(width: AppSizes.v5),
          Flexible(
            child: Text(
              product.statusLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle(
                color: product.statusColor,
                fontSize: AppTypography.font10_5,
                fontWeight: AppTypography.weight700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.metric, required this.showDivider});

  final ComparisonMetric metric;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.divider)),
            )
          : null,
      child: Row(
        children: [
          Container(
            width: compact ? AppSizes.v28 : AppSizes.v31,
            height: compact ? AppSizes.v28 : AppSizes.v31,
            decoration: const BoxDecoration(
              color: AppColors.toneFFF5F7F6,
              shape: BoxShape.circle,
            ),
            child: Icon(metric.icon, color: AppColors.textPrimary, size: AppSizes.iconFine),
          ),
          const SizedBox(width: AppSizes.v6),
          Expanded(
            child: Text(
              metric.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle(fontSize: compact ? AppTypography.font9_5 : AppTypography.font10_5),
            ),
          ),
          const SizedBox(width: AppSizes.v4),
          Text(
            metric.value,
            style: AppTextStyle(
              fontSize: compact ? AppTypography.font9_5 : AppTypography.font10_5,
              fontWeight: AppTypography.weight700,
            ),
          ),
          const SizedBox(width: AppSizes.v5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v6, vertical: AppSpacing.v5),
            decoration: BoxDecoration(
              color: metric.levelColor,
              borderRadius: BorderRadius.circular(AppRadii.v6),
            ),
            child: Text(
              metric.level,
              style: AppTextStyle(
                color: AppColors.white,
                fontSize: compact ? AppTypography.font8_5 : AppTypography.font9_5,
                fontWeight: AppTypography.weight700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WarningBox extends StatelessWidget {
  const _WarningBox({required this.product});

  final ComparisonProduct product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: AppSizes.v75),
      padding: const EdgeInsets.all(AppSpacing.v10),
      decoration: BoxDecoration(
        color: product.warningBackground,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: product.warningColor.withOpacity(AppOpacity.v0_22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(product.warningIcon, color: product.warningColor, size: AppSizes.iconHero),
          const SizedBox(width: AppSizes.v8),
          Expanded(
            child: Text(
              product.warning,
              style: const AppTextStyle(fontSize: AppTypography.font10_5, height: AppTypography.lineHeight1_3),
            ),
          ),
        ],
      ),
    );
  }
}

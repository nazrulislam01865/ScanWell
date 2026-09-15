import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../data/product_detail_data.dart';

class ProductDetailTopBar extends StatelessWidget {
  const ProductDetailTopBar({
    required this.showBookmark,
    required this.onBack,
    required this.onBookmark,
    required this.onShare,
    required this.onMore,
    super.key,
  });

  final bool showBookmark;
  final VoidCallback onBack;
  final VoidCallback onBookmark;
  final VoidCallback onShare;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.v44,
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: AppSizes.v40, height: AppSizes.v40),
            icon: const Icon(
              AppIcons.arrow_back_rounded,
              color: AppColors.primaryDark,
              size: AppSizes.iconFeatureLarge,
            ),
          ),
          const Spacer(),
          if (showBookmark)
            IconButton(
              onPressed: onBookmark,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: AppSizes.v40, height: AppSizes.v40),
              icon: const Icon(
                AppIcons.bookmark_border_rounded,
                color: AppColors.primaryDark,
                size: AppSizes.iconFeature,
              ),
            ),
          IconButton(
            onPressed: onShare,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: AppSizes.v40, height: AppSizes.v40),
            icon: const Icon(
              AppIcons.ios_share_rounded,
              color: AppColors.primaryDark,
              size: AppSizes.iconActionLarge,
            ),
          ),
          if (!showBookmark)
            IconButton(
              onPressed: onMore,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: AppSizes.v40, height: AppSizes.v40),
              icon: const Icon(
                AppIcons.more_horiz_rounded,
                color: AppColors.textPrimary,
                size: AppSizes.iconHero,
              ),
            ),
        ],
      ),
    );
  }
}

class ProductDetailHeader extends StatelessWidget {
  const ProductDetailHeader({
    required this.compactHeader,
    super.key,
  });

  final bool compactHeader;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final compactPhone = screenWidth < 390;
    final productImageSize = compactHeader
        ? (compactPhone ? 92.0 : 112.0)
        : (compactPhone ? 118.0 : 134.0);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: productImageSize,
          height: productImageSize,
          child: Image.asset(laysProductImage, fit: BoxFit.contain),
        ),
        SizedBox(width: compactHeader ? AppSizes.v12 : AppSizes.v15),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: compactHeader ? AppSpacing.xxs : AppSpacing.v6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  laysProductName,
                  maxLines: compactHeader ? 2 : 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.productDetailTitleFor(
                    compact: compactPhone,
                    dense: compactHeader,
                  ),
                ),
                SizedBox(height: compactHeader ? AppSizes.v4 : AppSizes.v5),
                const Text(
                  laysBrandName,
                  style: AppTextStyles.productDetailBrand,
                ),
                SizedBox(height: compactHeader ? AppSizes.v7 : AppSizes.v9),
                if (compactHeader)
                  const _CategoryText()
                else
                  const _CategoryPill(),
                SizedBox(height: compactHeader ? AppSizes.v8 : AppSizes.v9),
                Wrap(
                  spacing: compactHeader ? 9 : 10,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    _VerifiedDate(),
                    _AdminVerifiedBadge(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryText extends StatelessWidget {
  const _CategoryText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Snacks   •   Potato Chips',
      style: AppTextStyles.productDetailMeta.copyWith(
        color: AppColors.toneFF464D55,
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v12, vertical: AppSpacing.v6),
      decoration: BoxDecoration(
        color: AppColors.toneFFF0F4F1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Text(
        'Snacks  >  Potato Chips',
        style: AppTextStyles.productDetailMeta.copyWith(
          color: AppColors.toneFF3F474D,
        ),
      ),
    );
  }
}

class _VerifiedDate extends StatelessWidget {
  const _VerifiedDate();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          AppIcons.calendar_today_outlined,
          size: AppSizes.iconSm,
          color: AppColors.toneFF586069,
        ),
        SizedBox(width: AppSizes.v8),
        Text(
          'Last verified: May 18, 2025',
          style: AppTextStyles.productDetailMeta.copyWith(
            color: AppColors.toneFF4B535B,
          ),
        ),
      ],
    );
  }
}

class _AdminVerifiedBadge extends StatelessWidget {
  const _AdminVerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v9, vertical: AppSpacing.v5),
      decoration: BoxDecoration(
        color: AppColors.softGreen,
        borderRadius: BorderRadius.circular(AppRadii.v18),
        border: Border.all(color: AppColors.toneFFD0EBDD),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            AppIcons.verified_rounded,
            color: AppColors.primary,
            size: AppSizes.iconSm,
          ),
          SizedBox(width: AppSizes.v5),
          Text(
            'Admin Verified',
            style: AppTextStyles.productDetailBadge.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}

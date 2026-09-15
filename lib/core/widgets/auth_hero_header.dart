import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../layout/responsive_layout.dart';

/// Shared compact hero used by every authentication screen before dashboard.
///
/// Keeping title/body as Flutter text prevents oversized raster typography and
/// lets the header respond cleanly across compact phones and larger devices.
class AuthHeroHeader extends StatelessWidget {
  const AuthHeroHeader({
    required this.title,
    required this.description,
    required this.illustrationAsset,
    required this.illustrationSemanticsLabel,
    this.illustrationKey,
    super.key,
  });

  final String title;
  final String description;
  final String illustrationAsset;
  final String illustrationSemanticsLabel;
  final Key? illustrationKey;

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);
    final width = MediaQuery.sizeOf(context).width;
    final narrow = width < AppBreakpoints.denseContent;

    final logoWidth = ResponsiveLayout.value(
      context,
      compact: AppSizes.v132,
      phone: AppSizes.v145,
      tablet: AppSizes.v170,
    );
    final illustrationWidth = narrow
        ? AppSizes.v104
        : ResponsiveLayout.value(
            context,
            compact: AppSizes.v116,
            phone: AppSizes.v128,
            tablet: AppSizes.v160,
          );

    return Padding(
      padding: ResponsiveLayout.pagePadding(
        context,
        compactHorizontal: AppSpacing.lg,
        phoneHorizontal: AppSpacing.v22,
        tabletHorizontal: AppSpacing.v26,
        top: compact ? AppSpacing.v8 : AppSpacing.v12,
        bottom: compact ? AppSpacing.v16 : AppSpacing.v18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            image: true,
            label: 'ScanWell',
            child: Image.asset(
              AppAssets.scanwellWordmark,
              width: logoWidth,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Scan. Check. Choose Better.',
            style: AppTextStyles.authBrandTaglineFor(compact: compact),
          ),
          SizedBox(height: compact ? AppSpacing.v12 : AppSpacing.v14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.authHeroTitleFor(compact: compact),
                    ),
                    const SizedBox(height: AppSpacing.v6),
                    Text(
                      description,
                      style: AppTextStyles.authHeroBodyFor(compact: compact),
                    ),
                  ],
                ),
              ),
              SizedBox(width: compact ? AppSpacing.sm : AppSpacing.md),
              Semantics(
                image: true,
                label: illustrationSemanticsLabel,
                child: Image.asset(
                  illustrationAsset,
                  key: illustrationKey,
                  width: illustrationWidth,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

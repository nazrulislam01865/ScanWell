import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../core/widgets/app_button.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/main_bottom_navigation.dart';
import '../data/product_detail_data.dart';
import '../widgets/product_detail_header.dart';
import '../widgets/product_detail_tabs.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    this.initialTab = ProductDetailTab.overview,
    super.key,
  });

  final ProductDetailTab initialTab;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductDetailTab _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final isOverview = _selectedTab == ProductDetailTab.overview;
    final compact = MediaQuery.sizeOf(context).width < AppBreakpoints.comfortablePhone;
    final originalTextScale =
        MediaQuery.textScalerOf(context).scale(AppTypography.font14) /
            AppTypography.font14;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isOverview)
              _OverviewActionBar(
                forceStack: originalTextScale > AppSizes.v1_15,
                onSave: () => _showMessage('Product saved.'),
                onSuggestCorrection: () => Navigator.pushNamed(
                  context,
                  AppRoutes.suggestCorrection,
                ),
              ),
            const MainBottomNavigation(),
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: ResponsiveContent(
            maxWidth: AppSizes.contentNarrow,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    compact ? AppSpacing.v15 : AppSpacing.v21,
                    isOverview ? AppSpacing.sm : AppSpacing.v7,
                    compact ? AppSpacing.v15 : AppSpacing.v21,
                    AppSpacing.none,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate.fixed([
                      ProductDetailTopBar(
                        showBookmark: !isOverview,
                        onBack: () => Navigator.maybePop(context),
                        onBookmark: () => _showMessage('Product saved.'),
                        onShare: () => _showMessage('Share is ready.'),
                        onMore: () => _showMessage('More options are ready.'),
                      ),
                      SizedBox(height: isOverview ? AppSizes.v9 : AppSizes.v6),
                      ProductDetailHeader(compactHeader: !isOverview),
                      if (isOverview) ...[
                        const SizedBox(height: AppSizes.v15),
                        const _HealthScoreCard(),
                        const SizedBox(height: AppSizes.v12),
                      ] else
                        const SizedBox(height: AppSizes.v17),
                    ]),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ProductDetailTabs(
                    selectedTab: _selectedTab,
                    rounded: isOverview,
                    onTabSelected: (tab) => setState(() => _selectedTab = tab),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    compact ? AppSpacing.v15 : AppSpacing.v21,
                    AppSpacing.v18,
                    compact ? AppSpacing.v15 : AppSpacing.v21,
                    isOverview ? AppSpacing.v30 : AppSpacing.v28,
                  ),
                  sliver: SliverToBoxAdapter(child: _selectedContent()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectedContent() {
    switch (_selectedTab) {
      case ProductDetailTab.overview:
        return _OverviewContent(
          onViewAllConcerns: () => Navigator.pushNamed(
            context,
            AppRoutes.personalizedAlerts,
          ),
        );
      case ProductDetailTab.healthFlags:
        return const _HealthFlagsContent();
      case ProductDetailTab.nutrition:
        return const _NutritionContent();
      case ProductDetailTab.ingredients:
        return _IngredientsContent(
          onSuggestCorrection: () => Navigator.pushNamed(
            context,
            AppRoutes.suggestCorrection,
          ),
        );
      case ProductDetailTab.alternatives:
        return _AlternativesContent(
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.compareProducts,
          ),
        );
    }
  }
}

class _HealthScoreCard extends StatelessWidget {
  const _HealthScoreCard();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stackHealthLayout =
            constraints.maxWidth < AppBreakpoints.productDetailHealthStack;
        final compact = constraints.maxWidth < AppBreakpoints.denseContent;
        final iconSize = compact ? AppSizes.v42 : AppSizes.v46;
        final chartSize = compact ? AppSizes.v68 : AppSizes.v72;

        final healthIcon = Container(
          width: iconSize,
          height: iconSize,
          decoration: const BoxDecoration(
            color: AppColors.amber,
            shape: BoxShape.circle,
          ),
          child: Icon(
            AppIcons.priority_high_rounded,
            color: AppColors.white,
            size: compact ? AppSizes.v28 : AppSizes.v30,
          ),
        );

        final heading = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Health Score',
                  style: AppTextStyles.productDetailHealthLabel.copyWith(
                    color: AppColors.toneFF182128,
                  ),
                ),
                const SizedBox(width: AppSizes.v4),
                const Icon(
                  AppIcons.info_outline_rounded,
                  color: AppColors.amber,
                  size: AppSizes.v16,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.v3),
            Text(
              'Use with Caution',
              style: AppTextStyles.productDetailHealthStatusFor(
                compact: compact,
              ),
            ),
          ],
        );

        const supportingCopy = Text(
          'Some ingredients may not be ideal for daily consumption.',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.productDetailSupporting,
        );

        final score = _HealthScoreIndicator(
          size: chartSize,
          compact: compact,
        );

        return Container(
          padding: EdgeInsets.all(
            compact ? AppSpacing.v12 : AppSpacing.v14,
          ),
          decoration: BoxDecoration(
            color: AppColors.toneFFFFFCF3,
            borderRadius: BorderRadius.circular(AppRadii.xl),
            border: Border.all(color: AppColors.toneFFF8DFAD),
          ),
          child: stackHealthLayout
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        healthIcon,
                        const SizedBox(width: AppSizes.v10),
                        Expanded(child: heading),
                      ],
                    ),
                    const SizedBox(height: AppSizes.v10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(child: supportingCopy),
                        const SizedBox(width: AppSizes.v12),
                        score,
                      ],
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    healthIcon,
                    const SizedBox(width: AppSizes.v12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          heading,
                          const SizedBox(height: AppSizes.v5),
                          supportingCopy,
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSizes.v14),
                    score,
                  ],
                ),
        );
      },
    );
  }
}

class _HealthScoreIndicator extends StatelessWidget {
  const _HealthScoreIndicator({
    required this.size,
    required this.compact,
  });

  final double size;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.square(size - AppSizes.v3),
            painter: const _ScoreArcPainter(),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '58',
                style: AppTextStyles.productDetailScoreFor(
                  compact: compact,
                ),
              ),
              const SizedBox(height: AppSizes.v2),
              const Text(
                'out of 100',
                style: AppTextStyles.productDetailScoreCaption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreArcPainter extends CustomPainter {
  const _ScoreArcPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width * 0.105;
    final rect = Offset(stroke / 2, stroke / 2) &
        Size(size.width - stroke, size.height - stroke);
    final basePaint = Paint()
      ..color = AppColors.toneFFF8E4B2
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    final progressPaint = Paint()
      ..color = AppColors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -1.28, 4.25, false, basePaint);
    canvas.drawArc(rect, -1.28, 2.78, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _OverviewContent extends StatelessWidget {
  const _OverviewContent({required this.onViewAllConcerns});

  final VoidCallback onViewAllConcerns;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'At a Glance',
          style: AppTextStyles.productDetailSectionTitle,
        ),
        const SizedBox(height: AppSizes.v12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 9,
            mainAxisSpacing: 9,
            childAspectRatio: 0.90,
          ),
          itemCount: overviewMetrics.length,
          itemBuilder: (context, index) => _OverviewMetricTile(
            metric: overviewMetrics[index],
          ),
        ),
        const SizedBox(height: AppSizes.v14),
        const _InsightMessageCard(),
        const SizedBox(height: AppSizes.v18),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Top Health Concerns',
                style: AppTextStyles.productDetailSectionTitle,
              ),
            ),
            AppButton(
              label: 'View All',
              variant: AppButtonVariant.textStrong,
              size: AppButtonSize.inline,
              fullWidth: false,
              emphasis: AppButtonEmphasis.standard,
              onPressed: onViewAllConcerns,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.v9),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              topHealthConcerns.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                  right: index == topHealthConcerns.length - AppSpacing.v1 ? AppSpacing.none : AppSpacing.sm,
                ),
                child: _ConcernChip(concern: topHealthConcerns[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OverviewMetricTile extends StatelessWidget {
  const _OverviewMetricTile({required this.metric});

  final ProductNutritionMetric metric;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Container(
      padding: EdgeInsets.all(compact ? AppSpacing.v9 : AppSpacing.v10),
      decoration: BoxDecoration(
        color: metric.backgroundColor,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.toneFFE7EFE7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(metric.icon, color: metric.color, size: compact ? AppSizes.v17 : AppSizes.v19),
              const SizedBox(width: AppSizes.v5),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    metric.label,
                    maxLines: 1,
                    style: AppTextStyles.productDetailMetricLabel.copyWith(
                      color: AppColors.toneFF1E2A31,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            metric.value,
            style: AppTextStyles.productDetailMetricValue,
          ),
          const SizedBox(height: AppSizes.v6),
          Text(
            metric.level,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.productDetailMetricStatus.copyWith(
              color: metric.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightMessageCard extends StatelessWidget {
  const _InsightMessageCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(AppSpacing.v15, AppSpacing.v14, AppSpacing.v13, AppSpacing.v14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadii.v14),
        border: Border.all(color: AppColors.toneFFE9ECEB),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.toneFFE5F7EF,
            child: Icon(
              AppIcons.lightbulb_outline_rounded,
              color: AppColors.primary,
              size: AppSizes.iconControlTight,
            ),
          ),
          SizedBox(width: AppSizes.v12),
          Expanded(
            child: Text(
              'High in sodium and fat. Best enjoyed occasionally\nas part of a balanced diet.',
              style: AppTextStyles.productDetailBody,
            ),
          ),
          Icon(AppIcons.keyboard_arrow_down_rounded, size: AppSizes.iconProfileAction),
        ],
      ),
    );
  }
}

class _ConcernChip extends StatelessWidget {
  const _ConcernChip({required this.concern});

  final ProductHealthConcern concern;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v11, vertical: AppSpacing.v9),
      decoration: BoxDecoration(
        color: concern.backgroundColor,
        borderRadius: BorderRadius.circular(AppRadii.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(concern.icon, color: concern.color, size: AppSizes.iconFine),
          const SizedBox(width: AppSizes.v6),
          Text(
            concern.label,
            style: AppTextStyles.productDetailSupporting.copyWith(
              color: concern.color,
              fontWeight: AppTypography.weight600,
            ),
          ),
        ],
      ),
    );
  }
}

class _HealthFlagsContent extends StatelessWidget {
  const _HealthFlagsContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FlagSectionHeader(
          title: 'Red Flags',
          subtitle: 'Ingredients or nutrients that may be high.',
          color: AppColors.danger,
        ),
        const SizedBox(height: AppSizes.v13),
        _FlagCard(flag: redFlags[0]),
        const SizedBox(height: AppSizes.v8),
        _FlagCard(flag: redFlags[1]),
        const SizedBox(height: AppSizes.v22),
        const _FlagSectionHeader(
          title: 'Yellow Flags',
          subtitle: 'Things to be aware of. Okay in moderation.',
          color: AppColors.amber,
        ),
        const SizedBox(height: AppSizes.v13),
        _FlagCard(flag: yellowFlags[0]),
        const SizedBox(height: AppSizes.v8),
        _FlagCard(flag: yellowFlags[1]),
        const SizedBox(height: AppSizes.v22),
        const _FlagSectionHeader(
          title: 'Green Notes',
          subtitle: 'Positive points of this product.',
          color: AppColors.primary,
        ),
        const SizedBox(height: AppSizes.v13),
        _FlagCard(flag: greenNotes[0]),
        const SizedBox(height: AppSizes.v8),
        _FlagCard(flag: greenNotes[1]),
        const SizedBox(height: AppSizes.v16),
        const _MedicalDisclaimer(),
      ],
    );
  }
}

class _FlagSectionHeader extends StatelessWidget {
  const _FlagSectionHeader({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(AppIcons.flag_rounded, color: color, size: AppSizes.iconMd),
            const SizedBox(width: AppSizes.v8),
            Text(
              title,
              style: AppTextStyles.productDetailSectionTitle.copyWith(
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.v3),
        Text(
          subtitle,
          style: AppTextStyles.productDetailSectionSubtitle,
        ),
      ],
    );
  }
}

class _FlagCard extends StatelessWidget {
  const _FlagCard({required this.flag});

  final HealthFlagInfo flag;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;
    final hasLongMetric = flag.metricValue.contains('\n') || flag.metricValue.length > 12;
    final rightColumnWidth = compact ? 86.0 : 104.0;

    return Container(
      constraints: BoxConstraints(minHeight: compact ? AppSizes.v82 : AppSizes.v88),
      padding: EdgeInsets.fromLTRB(
        compact ? AppSpacing.md : AppSpacing.v14,
        compact ? AppSpacing.md : AppSpacing.v13,
        compact ? AppSpacing.md : AppSpacing.v14,
        compact ? AppSpacing.md : AppSpacing.v13,
      ),
      decoration: BoxDecoration(
        color: flag.backgroundColor,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: flag.borderColor),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: compact ? 25 : 27,
                backgroundColor: AppColors.white.withOpacity(AppOpacity.v0_55),
                child: Icon(flag.icon, color: flag.color, size: compact ? AppSizes.v29 : AppSizes.v32),
              ),
            ),
            SizedBox(width: compact ? AppSizes.v12 : AppSizes.v14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    flag.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.productDetailCardTitle,
                  ),
                  const SizedBox(height: AppSizes.v6),
                  Text(
                    flag.description,
                    maxLines: compact ? 3 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.productDetailSupporting.copyWith(
                      color: AppColors.textStrong,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: AppSizes.v1,
              margin: EdgeInsets.symmetric(horizontal: compact ? AppSpacing.v10 : AppSpacing.v13),
              color: flag.borderColor,
            ),
            SizedBox(
              width: rightColumnWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    flag.metricLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.productDetailMetricLabel.copyWith(
                      color: AppColors.toneFF2F3842,
                    ),
                  ),
                  SizedBox(height: hasLongMetric ? AppSizes.v5 : AppSizes.v4),
                  Text(
                    flag.metricValue,
                    maxLines: hasLongMetric ? 4 : 1,
                    overflow: TextOverflow.ellipsis,
                    style: hasLongMetric
                        ? AppTextStyles.productDetailSupporting.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: AppTypography.weight600,
                          )
                        : AppTextStyles.productDetailMetricValue,
                  ),
                  if (flag.servingText.isNotEmpty) ...[
                    const SizedBox(height: AppSizes.v3),
                    Text(
                      flag.servingText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.productDetailMeta.copyWith(
                        color: AppColors.textStrong,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicalDisclaimer extends StatelessWidget {
  const _MedicalDisclaimer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v14, vertical: AppSpacing.v13),
      decoration: BoxDecoration(
        color: AppColors.toneFFF6F6F6,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.toneFFE9E9E9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(AppIcons.info_outline_rounded, size: AppSizes.iconCompact, color: AppColors.toneFF666C72),
          SizedBox(width: AppSizes.v10),
          Flexible(
            child: Text(
              'This app gives food information support, not medical advice.',
              textAlign: TextAlign.center,
              style: AppTextStyles.productDetailSupporting.copyWith(
                color: AppColors.toneFF555C63,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientsContent extends StatelessWidget {
  const _IngredientsContent({required this.onSuggestCorrection});

  final VoidCallback onSuggestCorrection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Ingredients',
                style: AppTextStyles.productDetailSectionTitle,
              ),
            ),
            SizedBox(
              width: AppSizes.v205,
              height: AppSizes.v37,
              child: TextField(
                style: AppTextStyles.productDetailBody,
                decoration: InputDecoration(
                  hintText: 'Search ingredients',
                  hintStyle: AppTextStyles.productDetailSupporting.copyWith(
                    color: AppColors.toneFF777E85,
                  ),
                  prefixIcon: const Icon(
                    AppIcons.search_rounded,
                    color: AppColors.toneFF555D66,
                    size: AppSizes.iconMd,
                  ),
                  contentPadding: EdgeInsets.zero,
                  filled: true,
                  fillColor: AppColors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.chip),
                    borderSide: const BorderSide(color: AppColors.toneFFE0E4E2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.chip),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.v12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v13, vertical: AppSpacing.v11),
          decoration: BoxDecoration(
            color: AppColors.successSurfaceSubtle,
            borderRadius: BorderRadius.circular(AppRadii.sm),
            border: Border.all(color: AppColors.toneFFE1F0E7),
          ),
          child: Row(
            children: [
              const Icon(AppIcons.eco_outlined, color: AppColors.primaryDark, size: AppSizes.iconMd),
              SizedBox(width: AppSizes.v12),
              Expanded(
                child: Text(
                  'Ingredients are listed in descending order by weight.',
                  style: AppTextStyles.productDetailSupporting.copyWith(
                    color: AppColors.toneFF273139,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.v13),
        const _IngredientsTextCard(),
        const SizedBox(height: AppSizes.v20),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Flagged Ingredients',
                style: AppTextStyles.productDetailSectionTitle,
              ),
            ),
            Container(
              width: AppSizes.v21,
              height: AppSizes.v21,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.danger,
                shape: BoxShape.circle,
              ),
              child: Text(
                '4',
                style: AppTextStyles.productDetailBadge.copyWith(
                  color: AppColors.white,
                  fontWeight: AppTypography.weight700,
                ),
              ),
            ),
            const Spacer(),
            Text(
              'What do these mean?',
              style: AppTextStyles.productDetailMeta.copyWith(
                color: AppColors.primaryDark,
                fontWeight: AppTypography.weight600,
              ),
            ),
            const SizedBox(width: AppSizes.v5),
            const Icon(
              AppIcons.help_outline_rounded,
              color: AppColors.primaryDark,
              size: AppSizes.iconCompact,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.v12),
        ...List.generate(
          ingredientFlags.length,
          (index) => Padding(
            padding: EdgeInsets.only(
              bottom: index == ingredientFlags.length - AppSpacing.v1 ? AppSpacing.none : AppSpacing.sm,
            ),
            child: IngredientFlagCard(flag: ingredientFlags[index]),
          ),
        ),
        const SizedBox(height: AppSizes.v12),
        AppButton(
          label: 'Suggest ingredient correction',
          icon: AppIcons.edit_outlined,
          variant: AppButtonVariant.outlineCompact,
          size: AppButtonSize.detail,
          emphasis: AppButtonEmphasis.standard,
          onPressed: onSuggestCorrection,
        ),
      ],
    );
  }
}

class _IngredientsTextCard extends StatelessWidget {
  const _IngredientsTextCard();

  static const _defaultStyle = AppTextStyles.productDetailIngredientBody;

  static const _underlinedStyle = AppTextStyles.productDetailIngredientEmphasis;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(AppSpacing.v19, AppSpacing.v17, AppSpacing.v19, AppSpacing.v17),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.toneFFE4E8E6),
      ),
      child: RichText(
        text: const TextSpan(
          style: _defaultStyle,
          children: [
            TextSpan(text: 'Potatoes, Edible Vegetable Oil (Palmolein Oil), Corn Starch, Seasoning ['),
            TextSpan(text: 'Sugar', style: _underlinedStyle),
            TextSpan(text: ', Iodized Salt, Milk Solids, Onion Powder, Maltodextrin, Flavour (Natural and Nature Identical Flavouring Substances), Yeast Extract, '),
            TextSpan(text: 'Citric Acid (INS 330)', style: _underlinedStyle),
            TextSpan(text: ', Acidity Regulator (INS 331(iii)), Flavour Enhancer ('),
            TextSpan(text: 'Monosodium Glutamate (INS 621)', style: _underlinedStyle),
            TextSpan(text: ', Disodium Inosinate (INS 631), '),
            TextSpan(text: 'Disodium Guanylate (INS 627)', style: _underlinedStyle),
            TextSpan(text: '], '),
            TextSpan(text: 'Anticaking Agent (INS 551)', style: _underlinedStyle),
            TextSpan(text: ', Nature Identical Flavouring Substances.'),
          ],
        ),
      ),
    );
  }
}

class IngredientFlagCard extends StatelessWidget {
  const IngredientFlagCard({required this.flag, super.key});

  final IngredientFlagInfo flag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.md),
      decoration: BoxDecoration(
        color: flag.backgroundColor.withOpacity(AppOpacity.v0_55),
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: flag.borderColor),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: flag.backgroundColor,
            child: Icon(flag.icon, color: flag.color, size: AppSizes.iconFeatureLarge),
          ),
          const SizedBox(width: AppSizes.v12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        flag.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.productDetailCardTitle.copyWith(
                          color: AppColors.toneFF1C262D,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.v8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.v3,
                      ),
                      decoration: BoxDecoration(
                        color: flag.severityBackgroundColor,
                        borderRadius: BorderRadius.circular(AppRadii.sm),
                        border: Border.all(color: flag.borderColor),
                      ),
                      child: Text(
                        flag.severity,
                        style: AppTextStyles.productDetailBadge.copyWith(
                          color: flag.severityColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.v4),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Reason: ',
                        style: AppTextStyles.productDetailInlineStrong,
                      ),
                      TextSpan(text: flag.reason),
                    ],
                  ),
                  style: AppTextStyles.productDetailMeta.copyWith(
                    color: AppColors.textStrong,
                  ),
                ),
                const SizedBox(height: AppSizes.v2),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Common concern: ',
                        style: AppTextStyles.productDetailInlineStrong,
                      ),
                      TextSpan(text: flag.concern),
                    ],
                  ),
                  style: AppTextStyles.productDetailMeta.copyWith(
                    color: AppColors.textStrong,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.v5),
          const Icon(AppIcons.chevron_right_rounded, size: AppSizes.iconFeature),
        ],
      ),
    );
  }
}

class _NutritionContent extends StatelessWidget {
  const _NutritionContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nutrition',
          style: AppTextStyles.productDetailSectionTitle,
        ),
        const SizedBox(height: AppSizes.v12),
        ...overviewMetrics.map(
          (metric) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _NutritionRow(metric: metric),
          ),
        ),
      ],
    );
  }
}

class _NutritionRow extends StatelessWidget {
  const _NutritionRow({required this.metric});

  final ProductNutritionMetric metric;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.v13),
      decoration: BoxDecoration(
        color: metric.backgroundColor,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: AppColors.toneFFE5EDE6),
      ),
      child: Row(
        children: [
          Icon(metric.icon, color: metric.color, size: AppSizes.iconLg),
          const SizedBox(width: AppSizes.v12),
          Expanded(
            child: Text(
              metric.label,
              style: AppTextStyles.productDetailCardTitle,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                metric.value,
                style: AppTextStyles.productDetailMetricValue,
              ),
              Text(
                metric.level,
                style: AppTextStyles.productDetailMetricStatus.copyWith(
                  color: metric.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlternativesContent extends StatelessWidget {
  const _AlternativesContent({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.successSurfaceSubtle,
      borderRadius: BorderRadius.circular(AppRadii.v14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.v14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.v18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.v14),
            border: Border.all(color: AppColors.toneFFDCEFE5),
          ),
          child: const Column(
            children: [
              Icon(
                AppIcons.compare_arrows_rounded,
                color: AppColors.primary,
                size: AppSizes.iconDisplayLarge,
              ),
              SizedBox(height: AppSizes.v10),
              Text(
                'Healthier alternatives will appear here.',
                textAlign: TextAlign.center,
                style: AppTextStyles.productDetailCardTitle,
              ),
              SizedBox(height: AppSizes.v5),
              Text(
                'Tap to compare products side by side.',
                textAlign: TextAlign.center,
                style: AppTextStyles.productDetailSupporting,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverviewActionBar extends StatelessWidget {
  const _OverviewActionBar({
    required this.onSave,
    required this.onSuggestCorrection,
    this.forceStack = false,
  });

  final VoidCallback onSave;
  final VoidCallback onSuggestCorrection;
  final bool forceStack;

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);

    return Container(
      padding: EdgeInsets.fromLTRB(
        compact ? AppSpacing.v15 : AppSpacing.v18,
        AppSpacing.v8,
        compact ? AppSpacing.v15 : AppSpacing.v18,
        AppSpacing.v8,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.toneFFE8E8E8)),
        boxShadow: AppShadows.bottomBar,
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final stackActions = forceStack ||
                constraints.maxWidth <
                    AppBreakpoints.productDetailActionsStack;

            final saveButton = AppButton(
              label: 'Save Product',
              buttonKey: const Key('save-product-action'),
              icon: AppIcons.bookmark_border_rounded,
              variant: AppButtonVariant.outlineDetail,
              size: AppButtonSize.productDetailAction,
              emphasis: AppButtonEmphasis.standard,
              fitLabel: true,
              onPressed: onSave,
            );

            final correctionButton = AppButton(
              label: 'Suggest Correction',
              buttonKey: const Key('suggest-correction-action'),
              icon: AppIcons.edit_outlined,
              variant: AppButtonVariant.primaryDetail,
              size: AppButtonSize.productDetailAction,
              emphasis: AppButtonEmphasis.standard,
              fitLabel: true,
              onPressed: onSuggestCorrection,
            );

            if (stackActions) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  saveButton,
                  const SizedBox(height: AppSizes.v8),
                  correctionButton,
                ],
              );
            }

            return Row(
              children: [
                Expanded(flex: 5, child: saveButton),
                const SizedBox(width: AppSizes.v10),
                Expanded(flex: 7, child: correctionButton),
              ],
            );
          },
        ),
      ),
    );
  }
}


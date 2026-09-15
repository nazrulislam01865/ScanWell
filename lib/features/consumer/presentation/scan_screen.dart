import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../core/widgets/app_button.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/main_bottom_navigation.dart';
import '../../auth/data/dummy_auth_service.dart';
import '../data/consumer_product.dart';
import '../data/demo_consumer_data.dart';
import '../widgets/health_flag_badge.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final firstName = DummyAuthService.instance.displayName.trim().split(' ').first;
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Scaffold(
      bottomNavigationBar: const MainBottomNavigation(
        currentDestination: MainNavigationDestination.scan,
      ),
      body: SafeArea(
        bottom: false,
        child: ResponsiveContent(
          maxWidth: AppSizes.contentComfortable,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: ResponsiveLayout.pagePadding(
                  context,
                  compactHorizontal: AppSpacing.lg,
                  phoneHorizontal: AppSpacing.xl,
                  tabletHorizontal: AppSpacing.v28,
                  top: compact ? 18 : 24,
                  bottom: AppSpacing.v18,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    _ScanHeader(
                      firstName: firstName,
                      onNotifications: () =>
                          _showMessage(context, 'You have 3 notifications.'),
                    ),
                    SizedBox(height: compact ? AppSizes.v15 : AppSizes.v19),
                    _ScanProductCard(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.productCamera,
                      ),
                    ),
                    const SizedBox(height: AppSizes.v14),
                    _QuickActions(
                      onSearch: () =>
                          Navigator.pushNamed(context, AppRoutes.productSearch),
                      onSaved: () => _showMessage(
                        context,
                        'Saved products are ready for API integration.',
                      ),
                      onHistory: () => _showMessage(
                        context,
                        'Scan history is ready for API integration.',
                      ),
                    ),
                    const SizedBox(height: AppSizes.v18),
                    _SectionHeader(
                      title: 'Recent Scans',
                      actionLabel: 'View all',
                      onTap: () => _showMessage(
                        context,
                        'All scan history is ready for API integration.',
                      ),
                    ),
                    const SizedBox(height: AppSizes.v7),
                    _RecentScansList(
                      onProductTap: (_) => Navigator.pushNamed(
                        context,
                        AppRoutes.productDetail,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScanHeader extends StatelessWidget {
  const _ScanHeader({
    required this.firstName,
    required this.onNotifications,
  });

  final String firstName;
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assalamu Alaikum,',
                style: AppTextStyle(
                  fontSize: compact ? AppTypography.font23 : AppTypography.font26,
                  height: AppTypography.lineHeight1_1,
                  fontWeight: AppTypography.weight800,
                  letterSpacing: AppTypography.letterSpacingn0_4,
                ),
              ),
              const SizedBox(height: AppSizes.v3),
              Text(
                '$firstName 👋',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle(
                  color: AppColors.primary,
                  fontSize: compact ? AppTypography.font24 : AppTypography.font27,
                  height: AppTypography.lineHeight1_08,
                  fontWeight: AppTypography.weight800,
                  letterSpacing: AppTypography.letterSpacingn0_4,
                ),
              ),
              const SizedBox(height: AppSizes.v10),
              Text(
                'Scan a product to check health flags.',
                style: AppTextStyle(
                  color: AppColors.textSecondary,
                  fontSize: compact ? AppTypography.font13 : AppTypography.font14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSizes.v12),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              color: AppColors.white,
              shape: const CircleBorder(
                side: BorderSide(color: AppColors.toneFFDDEDE2),
              ),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onNotifications,
                child: SizedBox(
                  width: compact ? AppSizes.v47 : AppSizes.v52,
                  height: compact ? AppSizes.v47 : AppSizes.v52,
                  child: Icon(
                    AppIcons.notifications_none_rounded,
                    color: AppColors.primary,
                    size: compact ? AppSizes.v27 : AppSizes.v30,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 7,
              top: AppSpacing.xs,
              child: Container(
                width: AppSizes.v8,
                height: AppSizes.v8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ScanProductCard extends StatelessWidget {
  const _ScanProductCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.v19),
        onTap: onTap,
        child: Ink(
          height: compact ? AppSizes.v240 : AppSizes.v265,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.v19),
            border: Border.all(color: AppColors.toneFFD7EFE0),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.toneFFF7FFFA, AppColors.toneFFEAFBF1],
            ),
          ),
          child: Stack(
            children: [
              const Positioned(
                left: -22,
                top: AppSpacing.v47,
                child: _BotanicalDecoration(
                  angle: -0.2,
                  opacity: AppOpacity.v0_12,
                ),
              ),
              const Positioned(
                right: -25,
                bottom: AppSpacing.md,
                child: _BotanicalDecoration(
                  angle: 0.35,
                  opacity: AppOpacity.v0_1,
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: compact ? AppSizes.v148 : AppSizes.v165,
                      height: compact ? AppSizes.v148 : AppSizes.v165,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: Size.square(compact ? AppSizes.v142 : AppSizes.v158),
                            painter: const _ScanCornersPainter(),
                          ),
                          Container(
                            width: compact ? AppSizes.v105 : AppSizes.v116,
                            height: compact ? AppSizes.v105 : AppSizes.v116,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: AppShadows.scanAction,
                            ),
                            child: Icon(
                              AppIcons.photo_camera_outlined,
                              color: AppColors.white,
                              size: compact ? AppSizes.v50 : AppSizes.v56,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Scan Product',
                      style: AppTextStyle(
                        color: AppColors.primary,
                        fontSize: compact ? AppTypography.font25 : AppTypography.font28,
                        height: AppTypography.lineHeight1_05,
                        fontWeight: AppTypography.weight800,
                        letterSpacing: AppTypography.letterSpacingn0_35,
                      ),
                    ),
                    const SizedBox(height: AppSizes.v7),
                    Text(
                      'Barcode, nutrition label, or ingredients',
                      textAlign: TextAlign.center,
                      style: AppTextStyle(
                        color: AppColors.textSecondary,
                        fontSize: compact ? AppTypography.font13 : AppTypography.font14_5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BotanicalDecoration extends StatelessWidget {
  const _BotanicalDecoration({
    required this.angle,
    required this.opacity,
  });

  final double angle;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Icon(
        AppIcons.eco_rounded,
        size: AppSizes.iconMicro,
        color: AppColors.primary.withOpacity(opacity),
      ),
    );
  }
}

class _ScanCornersPainter extends CustomPainter {
  const _ScanCornersPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    const corner = 22.0;
    const inset = 5.0;

    final paths = <Path>[
      Path()
        ..moveTo(inset, inset + corner)
        ..lineTo(inset, inset)
        ..lineTo(inset + corner, inset),
      Path()
        ..moveTo(size.width - inset - corner, inset)
        ..lineTo(size.width - inset, inset)
        ..lineTo(size.width - inset, inset + corner),
      Path()
        ..moveTo(inset, size.height - inset - corner)
        ..lineTo(inset, size.height - inset)
        ..lineTo(inset + corner, size.height - inset),
      Path()
        ..moveTo(size.width - inset - corner, size.height - inset)
        ..lineTo(size.width - inset, size.height - inset)
        ..lineTo(size.width - inset, size.height - inset - corner),
    ];

    for (final path in paths) {
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({
    required this.onSearch,
    required this.onSaved,
    required this.onHistory,
  });

  final VoidCallback onSearch;
  final VoidCallback onSaved;
  final VoidCallback onHistory;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;
    return Container(
      padding: EdgeInsets.symmetric(vertical: compact ? AppSpacing.md : AppSpacing.v15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadii.v18),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.softRaised,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _QuickActionItem(
              icon: AppIcons.search_rounded,
              label: 'Search Product',
              onTap: onSearch,
            ),
          ),
          const _QuickActionDivider(),
          Expanded(
            child: _QuickActionItem(
              icon: AppIcons.bookmark_rounded,
              label: 'My Saved\nProducts',
              onTap: onSaved,
            ),
          ),
          const _QuickActionDivider(),
          Expanded(
            child: _QuickActionItem(
              icon: AppIcons.schedule_rounded,
              label: 'Scan History',
              onTap: onHistory,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v3),
        child: Column(
          children: [
            Container(
              width: compact ? AppSizes.v43 : AppSizes.v48,
              height: compact ? AppSizes.v43 : AppSizes.v48,
              decoration: const BoxDecoration(
                color: AppColors.softGreen,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: compact ? AppSizes.v25 : AppSizes.v28,
              ),
            ),
            const SizedBox(height: AppSizes.v8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: AppTextStyle(
                fontSize: compact ? AppTypography.font11 : AppTypography.font12_5,
                height: AppTypography.lineHeight1_25,
                fontWeight: AppTypography.weight600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionDivider extends StatelessWidget {
  const _QuickActionDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.v1,
      height: AppSizes.v73,
      margin: const EdgeInsets.only(top: AppSpacing.xs),
      color: AppColors.divider,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onTap,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const AppTextStyle(fontSize: AppTypography.font17, fontWeight: AppTypography.weight800),
          ),
        ),
        AppButton(
          label: actionLabel,
          icon: AppIcons.chevron_right_rounded,
          iconAlignment: IconAlignment.end,
          variant: AppButtonVariant.text,
          size: AppButtonSize.compact,
          emphasis: AppButtonEmphasis.standard,
          fullWidth: false,
          onPressed: onTap,
        ),
      ],
    );
  }
}

class _RecentScansList extends StatelessWidget {
  const _RecentScansList({required this.onProductTap});

  final ValueChanged<ConsumerProduct> onProductTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadii.v17),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.subtleCard,
      ),
      child: Column(
        children: List.generate(
          recentScans.length,
          (index) => _RecentScanRow(
            product: recentScans[index],
            showDivider: index != recentScans.length - 1,
            onTap: () => onProductTap(recentScans[index]),
          ),
        ),
      ),
    );
  }
}

class _RecentScanRow extends StatelessWidget {
  const _RecentScanRow({
    required this.product,
    required this.showDivider,
    required this.onTap,
  });

  final ConsumerProduct product;
  final bool showDivider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minHeight: compact ? AppSizes.v78 : AppSizes.v88),
        padding: EdgeInsets.fromLTRB(
          compact ? AppSpacing.v10 : AppSpacing.v13,
          compact ? AppSpacing.sm : AppSpacing.v10,
          compact ? AppSpacing.sm : AppSpacing.v11,
          compact ? AppSpacing.sm : AppSpacing.v10,
        ),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(bottom: BorderSide(color: AppColors.divider))
              : null,
        ),
        child: Row(
          children: [
            SizedBox(
              width: compact ? AppSizes.v55 : AppSizes.v65,
              height: compact ? AppSizes.v60 : AppSizes.v68,
              child: Image.asset(product.imageAsset, fit: BoxFit.contain),
            ),
            SizedBox(width: compact ? AppSizes.v9 : AppSizes.v12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle(
                      fontSize: compact ? AppTypography.font11_5 : AppTypography.font12_5,
                      fontWeight: AppTypography.weight700,
                    ),
                  ),
                  const SizedBox(height: AppSizes.v3),
                  Text(
                    product.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle(
                      color: AppColors.textSecondary,
                      fontSize: compact ? AppTypography.font10_5 : AppTypography.font11_5,
                    ),
                  ),
                  const SizedBox(height: AppSizes.v5),
                  Row(
                    children: [
                      const Icon(
                        AppIcons.schedule_rounded,
                        size: AppSizes.iconTiny,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSizes.v4),
                      Flexible(
                        child: Text(
                          product.scannedAt ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle(
                            color: AppColors.textSecondary,
                            fontSize: compact ? AppTypography.font9_5 : AppTypography.font10_5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSizes.v6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: HealthFlagBadge(flag: product.healthFlag, compact: true),
            ),
            Icon(
              AppIcons.chevron_right_rounded,
              color: AppColors.toneFF7F858B,
              size: compact ? AppSizes.v20 : AppSizes.v22,
            ),
          ],
        ),
      ),
    );
  }
}

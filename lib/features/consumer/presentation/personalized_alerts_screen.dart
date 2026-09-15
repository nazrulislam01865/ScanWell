import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../core/widgets/app_button.dart';

import '../../../core/layout/responsive_layout.dart';
import '../data/product_detail_data.dart';

class PersonalizedAlertsScreen extends StatelessWidget {
  const PersonalizedAlertsScreen({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQuery.copyWith(textScaler: TextScaler.noScaling),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: ResponsiveContent(
            maxWidth: AppSizes.contentMedium,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _ProductScannerAppBar(
                        onBack: () => Navigator.maybePop(context),
                        onHelp: () => _showMessage(
                          context,
                          'Health alerts are based on your selected concerns.',
                        ),
                      ),
                      const _PersonalizedAlertsBody(),
                    ],
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

class _PersonalizedAlertsBody extends StatelessWidget {
  const _PersonalizedAlertsBody();

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);
    final horizontalPadding = compact ? 20.0 : 24.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        compact ? AppSpacing.xxl : AppSpacing.v28,
        horizontalPadding,
        AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'Personalized alerts for you',
                maxLines: 1,
                style: AppTextStyles.displayMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.v15),
          Text(
            'Based on your selected health concerns.',
            style: AppTextStyle(
              color: AppColors.textSecondary,
              fontSize: compact ? AppTypography.font15 : AppTypography.font16,
              height: AppTypography.lineHeight1_25,
              fontWeight: AppTypography.weight500,
            ),
          ),
          const SizedBox(height: AppSizes.v26),
          const _HealthConcernSelectorRow(),
          SizedBox(height: compact ? AppSizes.v32 : AppSizes.v36),
          ...List.generate(
            personalizedAlerts.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                bottom: index == personalizedAlerts.length - AppSpacing.v1 ? AppSpacing.none : AppSpacing.xxl,
              ),
              child: _PersonalizedAlertCard(
                alert: personalizedAlerts[index],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.v40),
          const _UpdateHealthProfileButton(),
          const SizedBox(height: AppSizes.v18),
          const _PrivacyNote(),
          const SizedBox(height: AppSizes.v18),
        ],
      ),
    );
  }
}

class _ProductScannerAppBar extends StatelessWidget {
  const _ProductScannerAppBar({
    required this.onBack,
    required this.onHelp,
  });

  final VoidCallback onBack;
  final VoidCallback onHelp;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.v56,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.toneFFE8EBEA)),
        boxShadow: AppShadows.topBar,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: AppSizes.v42, height: AppSizes.v42),
            icon: const Icon(
              AppIcons.arrow_back_rounded,
              color: AppColors.primaryDark,
              size: AppSizes.iconFeature,
            ),
          ),
          const Expanded(child: SizedBox()),
          const _ScannerTitle(),
          const Expanded(child: SizedBox()),
          IconButton(
            onPressed: onHelp,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: AppSizes.v42, height: AppSizes.v42),
            icon: const Icon(
              AppIcons.help_outline_rounded,
              color: AppColors.primaryDark,
              size: AppSizes.iconFeatureLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerTitle extends StatelessWidget {
  const _ScannerTitle();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ShieldLeafIcon(size: AppSizes.iconDisplayMedium),
        SizedBox(width: AppSizes.v11),
        Text(
          'Product Scanner',
          style: AppTextStyle(
            color: AppColors.primaryDark,
            fontSize: AppTypography.font20,
            height: AppTypography.lineHeight1,
            fontWeight: AppTypography.weight900,
            letterSpacing: AppTypography.letterSpacingn0_3,
          ),
        ),
      ],
    );
  }
}

class _HealthConcernSelectorRow extends StatelessWidget {
  const _HealthConcernSelectorRow();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 360;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          child: Row(
            children: [
              _HealthConcernChip(
                label: 'Diabetes',
                icon: AppIcons.water_drop_outlined,
                compact: compact,
              ),
              SizedBox(width: compact ? AppSizes.v10 : AppSizes.v12),
              _HealthConcernChip(
                label: 'Kidney concern',
                icon: AppIcons.spa_outlined,
                compact: compact,
              ),
              SizedBox(width: compact ? AppSizes.v10 : AppSizes.v12),
              _HealthConcernChip(
                label: 'High blood pressure',
                icon: AppIcons.monitor_heart_outlined,
                compact: compact,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HealthConcernChip extends StatelessWidget {
  const _HealthConcernChip({
    required this.label,
    required this.icon,
    required this.compact,
  });

  final String label;
  final IconData icon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        compact ? AppSpacing.v11 : AppSpacing.v13,
        compact ? AppSpacing.sm : AppSpacing.v9,
        compact ? AppSpacing.v7 : AppSpacing.sm,
        compact ? AppSpacing.sm : AppSpacing.v9,
      ),
      decoration: BoxDecoration(
        color: AppColors.toneFFF0FAEC,
        borderRadius: BorderRadius.circular(AppRadii.xxl),
        border: Border.all(color: AppColors.toneFFE0F2D9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primaryDark, size: compact ? AppSizes.v21 : AppSizes.v23),
          SizedBox(width: compact ? AppSizes.v7 : AppSizes.v8),
          Text(
            label,
            maxLines: 1,
            style: AppTextStyle(
              color: AppColors.primaryDark,
              fontSize: compact ? AppTypography.font12 : AppTypography.font12_6,
              fontWeight: AppTypography.weight900,
            ),
          ),
          SizedBox(width: compact ? AppSizes.v7 : AppSizes.v8),
          CircleAvatar(
            radius: compact ? 8.5 : 9,
            backgroundColor: AppColors.primary,
            child: const Icon(AppIcons.check_rounded, color: AppColors.white, size: AppSizes.iconXs),
          ),
        ],
      ),
    );
  }
}

class _PersonalizedAlertCard extends StatelessWidget {
  const _PersonalizedAlertCard({required this.alert});

  final PersonalizedAlertInfo alert;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 360;
        final iconSize = compact ? 82.0 : 92.0;

        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: compact ? AppSizes.v124 : AppSizes.v132),
          child: Container(
            padding: EdgeInsets.fromLTRB(
              compact ? AppSpacing.v13 : AppSpacing.v17,
              compact ? AppSpacing.v13 : AppSpacing.v15,
              compact ? AppSpacing.md : AppSpacing.lg,
              compact ? AppSpacing.v13 : AppSpacing.v15,
            ),
            decoration: BoxDecoration(
              color: alert.backgroundColor,
              borderRadius: BorderRadius.circular(AppRadii.v17),
              border: Border.all(color: alert.borderColor, width: AppSizes.v1_15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    color: alert.badgeColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    alert.icon,
                    color: alert.color,
                    size: compact ? AppSizes.v54 : AppSizes.v61,
                  ),
                ),
                SizedBox(width: compact ? AppSizes.v16 : AppSizes.v22),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AlertConditionBadge(alert: alert, compact: compact),
                      SizedBox(height: compact ? AppSizes.v10 : AppSizes.v12),
                      Text(
                        alert.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle(
                          color: AppColors.textPrimary,
                          fontSize: compact ? AppTypography.font20 : AppTypography.font23,
                          height: AppTypography.lineHeight1_08,
                          fontWeight: AppTypography.weight900,
                          letterSpacing: AppTypography.letterSpacingn0_45,
                        ),
                      ),
                      SizedBox(height: compact ? AppSizes.v8 : AppSizes.v9),
                      Text(
                        alert.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle(
                          color: AppColors.toneFF5A6067,
                          fontSize: compact ? AppTypography.font13_8 : AppTypography.font15_3,
                          height: AppTypography.lineHeight1_24,
                          fontWeight: AppTypography.weight500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.v8),
                const Icon(
                  AppIcons.chevron_right_rounded,
                  color: AppColors.black,
                  size: AppSizes.iconHeroLarge,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AlertConditionBadge extends StatelessWidget {
  const _AlertConditionBadge({required this.alert, required this.compact});

  final PersonalizedAlertInfo alert;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppSpacing.v13 : AppSpacing.v15,
        vertical: compact ? AppSpacing.v7 : AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: alert.badgeColor,
        borderRadius: BorderRadius.circular(AppRadii.v18),
      ),
      child: Text(
        alert.condition,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle(
          color: alert.color,
          fontSize: compact ? AppTypography.font12_7 : AppTypography.font13_8,
          height: AppTypography.lineHeight1,
          fontWeight: AppTypography.weight900,
        ),
      ),
    );
  }
}

class _UpdateHealthProfileButton extends StatelessWidget {
  const _UpdateHealthProfileButton();

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);

    return AppButton(
      label: 'Update My Health Profile',
      icon: AppIcons.person_outline_rounded,
      variant: AppButtonVariant.primaryElevated,
      size: compact ? AppButtonSize.profileCompact : AppButtonSize.profile,
      emphasis: AppButtonEmphasis.heavy,
      onPressed: () {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Health profile update is ready for API integration.'),
            ),
          );
      },
    );
  }
}

class _PrivacyNote extends StatelessWidget {
  const _PrivacyNote();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            AppIcons.lock_outline_rounded,
            color: AppColors.toneFF707780,
            size: AppSizes.iconFine,
          ),
          SizedBox(width: AppSizes.v7),
          Flexible(
            child: Text(
              'Your health information is private and secure.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle(
                color: AppColors.toneFF676E76,
                fontSize: AppTypography.font13_2,
                fontWeight: AppTypography.weight500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShieldLeafIcon extends StatelessWidget {
  const _ShieldLeafIcon({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _ShieldLeafPainter()),
    );
  }
}

class _ShieldLeafPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final shield = Path()
      ..moveTo(size.width * 0.50, size.height * 0.05)
      ..lineTo(size.width * 0.86, size.height * 0.18)
      ..lineTo(size.width * 0.82, size.height * 0.58)
      ..quadraticBezierTo(
        size.width * 0.76,
        size.height * 0.80,
        size.width * 0.50,
        size.height * 0.93,
      )
      ..quadraticBezierTo(
        size.width * 0.24,
        size.height * 0.80,
        size.width * 0.18,
        size.height * 0.58,
      )
      ..lineTo(size.width * 0.14, size.height * 0.18)
      ..close();
    canvas.drawPath(shield, paint);

    final stem = Path()
      ..moveTo(size.width * 0.50, size.height * 0.75)
      ..lineTo(size.width * 0.50, size.height * 0.25);
    canvas.drawPath(stem, paint);

    final leftLeaf = Path()
      ..moveTo(size.width * 0.50, size.height * 0.47)
      ..quadraticBezierTo(
        size.width * 0.27,
        size.height * 0.34,
        size.width * 0.31,
        size.height * 0.18,
      )
      ..quadraticBezierTo(
        size.width * 0.50,
        size.height * 0.22,
        size.width * 0.50,
        size.height * 0.47,
      );
    canvas.drawPath(leftLeaf, paint);

    final rightLeaf = Path()
      ..moveTo(size.width * 0.50, size.height * 0.47)
      ..quadraticBezierTo(
        size.width * 0.73,
        size.height * 0.34,
        size.width * 0.69,
        size.height * 0.18,
      )
      ..quadraticBezierTo(
        size.width * 0.50,
        size.height * 0.22,
        size.width * 0.50,
        size.height * 0.47,
      );
    canvas.drawPath(rightLeaf, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../core/widgets/app_button.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/main_bottom_navigation.dart';
import '../../auth/data/dummy_auth_service.dart';
import '../data/submission.dart';

class ContributorDashboardScreen extends StatelessWidget {
  const ContributorDashboardScreen({super.key});

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$feature is ready for API integration.')));
  }

  @override
  Widget build(BuildContext context) {
    final auth = DummyAuthService.instance;
    final firstName = auth.displayName.trim().split(' ').first;

    return Scaffold(
      bottomNavigationBar: const MainBottomNavigation(
        currentDestination: MainNavigationDestination.home,
      ),
      body: SafeArea(
        bottom: false,
        child: ResponsiveContent(
          maxWidth: AppSizes.contentXLarge,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: ResponsiveLayout.pagePadding(
              context,
              compactHorizontal: AppSpacing.md,
              phoneHorizontal: AppSpacing.v18,
              tabletHorizontal: AppSpacing.xxl,
              top: AppSpacing.v15,
              bottom: AppSpacing.v18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DashboardHeader(firstName: firstName),
                const SizedBox(height: AppSizes.v16),
                const _StatsRow(),
                const SizedBox(height: AppSizes.v19),
                const Text(
                  'What would you like to do?',
                  style: AppTextStyle(fontSize: AppTypography.font16, fontWeight: AppTypography.weight800),
                ),
                const SizedBox(height: AppSizes.v10),
                _ActionCards(
                  onTap: (title) {
                    if (title == 'Add New Product') {
                      Navigator.pushNamed(context, AppRoutes.scan);
                      return;
                    }
                    if (title == 'Continue Draft') {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.reviewExtractedData,
                      );
                      return;
                    }
                    if (title == 'View My Submissions') {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.reviewSubmission,
                      );
                      return;
                    }
                    _showComingSoon(context, title);
                  },
                ),
                const SizedBox(height: AppSizes.v16),
                _ImpactBanner(
                  onTap: () => _showComingSoon(context, 'Impact details'),
                ),
                const SizedBox(height: AppSizes.v17),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Recent Submissions',
                        style: AppTextStyles.sectionTitleSmall,
                      ),
                    ),
                    AppButton(
                      label: 'View All',
                      icon: AppIcons.chevron_right,
                      iconAlignment: IconAlignment.end,
                      variant: AppButtonVariant.text,
                      size: AppButtonSize.sectionAction,
                      fullWidth: false,
                      onPressed: () =>
                          _showComingSoon(context, 'All submissions'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.v5),
                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: List.generate(
                      recentSubmissions.length,
                      (index) => _SubmissionRow(
                        submission: recentSubmissions[index],
                        showDivider: index != recentSubmissions.length - 1,
                        onTap: () {
                          if (index == 0) {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.reviewSubmission,
                            );
                            return;
                          }
                          _showComingSoon(
                            context,
                            recentSubmissions[index].productName,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.v14),
                const _ContributionNote(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({required this.firstName});

  final String firstName;

  void _showMenuMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Menu is ready for integration.')),
    );
  }

  void _showNotifications(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have 3 notifications.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < AppBreakpoints.comfortablePhone;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => _showMenuMessage(context),
                  padding: const EdgeInsets.only(right: AppSpacing.v7, top: AppSpacing.xs),
                  constraints:
                      const BoxConstraints(minWidth: AppSizes.v38, minHeight: AppSizes.v38),
                  icon: const Icon(
                    AppIcons.menu,
                    color: AppColors.primary,
                    size: AppSizes.iconNavigation,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.v3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Assalamu Alaikum,',
                          style: AppTextStyle(
                            fontSize: AppTypography.font11_5,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '$firstName! 👋',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle(
                            fontSize: compact ? AppTypography.font20 : AppTypography.font22,
                            height: AppTypography.lineHeight1_05,
                            fontWeight: AppTypography.weight800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!compact) ...[
                  const _ContributorBadge(),
                  const SizedBox(width: AppSizes.v7),
                ],
                _NotificationButton(onPressed: () => _showNotifications(context)),
              ],
            ),
            if (compact) ...[
              const SizedBox(height: AppSizes.v8),
              const Padding(
                padding: EdgeInsets.only(left: AppSpacing.v45),
                child: _ContributorBadge(),
              ),
            ],
            const SizedBox(height: AppSizes.v9),
            const Text(
              'Thank you for helping build a healthier food database! 💚',
              style: AppTextStyle(fontSize: AppTypography.font12, color: AppColors.textSecondary),
            ),
          ],
        );
      },
    );
  }
}

class _ContributorBadge extends StatelessWidget {
  const _ContributorBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.v6),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v9, vertical: AppSpacing.v7),
      decoration: BoxDecoration(
        color: AppColors.softGreen,
        borderRadius: BorderRadius.circular(AppRadii.sm),
        border: Border.all(color: AppColors.toneFFD9EDE1),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(AppIcons.verified_user, size: AppSizes.iconXs, color: AppColors.primary),
          SizedBox(width: AppSizes.v5),
          Text(
            'Volunteer Contributor',
            style: AppTextStyle(
              fontSize: AppTypography.font9_5,
              color: AppColors.primaryDark,
              fontWeight: AppTypography.weight700,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(AppIcons.notifications_none, size: AppSizes.iconProfileAction),
          padding: const EdgeInsets.only(top: AppSpacing.v3),
          constraints: const BoxConstraints(minWidth: AppSizes.v36, minHeight: AppSizes.v36),
        ),
        Positioned(
          right: 0,
          top: AppSpacing.none,
          child: Container(
            width: AppSizes.v17,
            height: AppSizes.v17,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.error,
              shape: BoxShape.circle,
            ),
            child: const Text(
              '3',
              style: AppTextStyle(
                color: AppColors.white,
                fontSize: AppTypography.font9,
                fontWeight: AppTypography.weight800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    const cards = <_StatCard>[
      _StatCard(
        value: '128',
        title: 'Accepted Submissions',
        footer: 'Keep it up! 🎉',
        icon: AppIcons.check,
        iconColor: AppColors.primary,
        background: AppColors.toneFFF8FCFA,
      ),
      _StatCard(
        value: '14',
        title: 'Pending Review',
        footer: 'In review',
        icon: AppIcons.schedule,
        iconColor: AppColors.amber,
        background: AppColors.toneFFFFFCF6,
      ),
      _StatCard(
        value: '6',
        title: 'Rejected Submissions',
        footer: 'Keep improving',
        icon: AppIcons.close,
        iconColor: AppColors.error,
        background: AppColors.toneFFFFF9F9,
      ),
      _StatCard(
        value: '92%',
        title: 'Quality Score',
        footer: 'Excellent ⭐',
        icon: AppIcons.star,
        iconColor: AppColors.blue,
        background: AppColors.toneFFF9FBFD,
        info: true,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final fitsInline =
            constraints.maxWidth >= AppBreakpoints.dashboardCardsInline;
        final gap = AppSpacing.v9;
        final cardWidth = fitsInline
            ? (constraints.maxWidth - gap * (cards.length - 1)) / cards.length
            : AppSizes.dashboardStatCardWidth;

        final row = Row(
          children: List.generate(
            cards.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                right: index == cards.length - 1 ? AppSpacing.none : gap,
              ),
              child: SizedBox(
                key: ValueKey('dashboard-stat-card-$index'),
                width: cardWidth,
                height: AppSizes.dashboardStatCardHeight,
                child: cards[index],
              ),
            ),
          ),
        );

        if (fitsInline) return row;
        return SingleChildScrollView(
          key: const ValueKey('dashboard-stats-scroll'),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: row,
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.title,
    required this.footer,
    required this.icon,
    required this.iconColor,
    required this.background,
    this.info = false,
  });

  final String value;
  final String title;
  final String footer;
  final IconData icon;
  final Color iconColor;
  final Color background;
  final bool info;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.dashboardStatCardHeight,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.v9,
        AppSpacing.v11,
        AppSpacing.v9,
        AppSpacing.v10,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: AppSizes.v28,
                height: AppSizes.v28,
                decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
                child: Icon(icon, color: AppColors.white, size: AppSizes.iconCompact),
              ),
              const SizedBox(height: AppSizes.v7),
              Text(
                value,
                style: const AppTextStyle(
                  fontSize: AppTypography.font24,
                  height: AppTypography.lineHeight1,
                  fontWeight: AppTypography.weight800,
                ),
              ),
              const SizedBox(height: AppSizes.v7),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                style: const AppTextStyle(
                  fontSize: AppTypography.font11,
                  height: AppTypography.lineHeight1_28,
                ),
              ),
              const SizedBox(height: AppSizes.v8),
              Text(
                footer,
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                style: AppTextStyle(
                  fontSize: AppTypography.font9_5,
                  color: iconColor,
                  fontWeight: AppTypography.weight600,
                ),
              ),
            ],
          ),
          if (info)
            const Positioned(
              top: AppSpacing.n3,
              right: -2,
              child: Icon(
                AppIcons.info_outline,
                size: AppSizes.iconBadge,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}

class _ActionCards extends StatelessWidget {
  const _ActionCards({required this.onTap});

  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final actions = <_ActionCardData>[
      const _ActionCardData(
        title: 'Add New Product',
        description: 'Submit a new product for the database',
        icon: AppIcons.add,
        color: AppColors.primary,
        background: AppColors.toneFFF4FBF7,
      ),
      const _ActionCardData(
        title: 'Continue Draft',
        description: 'You have 2 drafts in progress',
        icon: AppIcons.description_outlined,
        color: AppColors.blue,
        background: AppColors.toneFFF4F9FD,
      ),
      const _ActionCardData(
        title: 'View My Submissions',
        description: 'Track all your submitted products',
        icon: AppIcons.format_list_bulleted,
        color: AppColors.purple,
        background: AppColors.toneFFF8F4FB,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final fitsInline =
            constraints.maxWidth >= AppBreakpoints.dashboardCardsInline;
        final gap = AppSpacing.v10;
        final cardWidth = fitsInline
            ? (constraints.maxWidth - gap * (actions.length - 1)) /
                actions.length
            : AppSizes.dashboardActionCardWidth;

        final row = Row(
          children: List.generate(
            actions.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                right: index == actions.length - 1 ? AppSpacing.none : gap,
              ),
              child: SizedBox(
                key: ValueKey('dashboard-action-card-$index'),
                width: cardWidth,
                height: AppSizes.dashboardActionCardHeight,
                child: _ActionCard(
                  data: actions[index],
                  onTap: () => onTap(actions[index].title),
                ),
              ),
            ),
          ),
        );

        if (fitsInline) return row;
        return SingleChildScrollView(
          key: const ValueKey('dashboard-actions-scroll'),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: row,
        );
      },
    );
  }
}

class _ActionCardData {
  const _ActionCardData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.background,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Color background;
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.data, required this.onTap});

  final _ActionCardData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Container(
          height: AppSizes.dashboardActionCardHeight,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.v13,
            AppSpacing.v12,
            AppSpacing.v11,
            AppSpacing.v11,
          ),
          decoration: BoxDecoration(
            color: data.background,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: AppSizes.v30,
                height: AppSizes.v30,
                decoration: BoxDecoration(color: data.color, shape: BoxShape.circle),
                child: Icon(data.icon, size: AppSizes.iconMd, color: AppColors.white),
              ),
              const SizedBox(height: AppSizes.v8),
              Text(
                data.title,
                maxLines: 2,
                softWrap: true,
                style: AppTextStyle(
                  color: data.color,
                  fontSize: AppTypography.font12,
                  fontWeight: AppTypography.weight700,
                ),
              ),
              const SizedBox(height: AppSizes.v4),
              Expanded(
                child: Text(
                  data.description,
                  maxLines: 3,
                  softWrap: true,
                  style: const AppTextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTypography.font10,
                    height: AppTypography.lineHeight1_35,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Icon(AppIcons.chevron_right, size: AppSizes.iconMd),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImpactBanner extends StatelessWidget {
  const _ImpactBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.toneFFF4FBF6,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v13, vertical: AppSpacing.v11),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < AppBreakpoints.microContent;

          final message = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.impactTrophy,
                width: compact ? AppSizes.v58 : AppSizes.v68,
                height: compact ? AppSizes.v58 : AppSizes.v68,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: AppSizes.v10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You’re making a real difference!',
                      style: AppTextStyle(
                        fontSize: AppTypography.font13,
                        fontWeight: AppTypography.weight800,
                      ),
                    ),
                    SizedBox(height: AppSizes.v5),
                    Text(
                      'Your contributions help thousands of people make healthier food choices.',
                      style: AppTextStyle(
                        fontSize: AppTypography.font10_5,
                        height: AppTypography.lineHeight1_35,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

          final button = AppButton(
            label: 'See Impact',
            variant: AppButtonVariant.outlineTight,
            size: AppButtonSize.toolbar,
            fullWidth: false,
            onPressed: onTap,
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                message,
                const SizedBox(height: AppSizes.v9),
                Align(alignment: Alignment.centerRight, child: button),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: message),
              const SizedBox(width: AppSizes.v10),
              button,
            ],
          );
        },
      ),
    );
  }
}

class _SubmissionRow extends StatelessWidget {
  const _SubmissionRow({
    required this.submission,
    required this.showDivider,
    required this.onTap,
  });

  final Submission submission;
  final bool showDivider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = _statusStyle(submission.status);

    return InkWell(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < AppBreakpoints.submissionCompact;

          return Container(
            constraints: const BoxConstraints(minHeight: AppSizes.v65),
            decoration: BoxDecoration(
              border: showDivider
                  ? const Border(
                      bottom: BorderSide(color: AppColors.divider),
                    )
                  : null,
            ),
            padding: const EdgeInsets.fromLTRB(AppSpacing.v10, AppSpacing.v7, AppSpacing.v7, AppSpacing.v7),
            child: Row(
              children: [
                SizedBox(
                  width: compact ? AppSizes.v50 : AppSizes.v62,
                  height: AppSizes.v54,
                  child: Image.asset(
                    submission.imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: compact ? AppSizes.v5 : AppSizes.v7),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        submission.productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const AppTextStyle(
                          fontSize: AppTypography.font11_5,
                          fontWeight: AppTypography.weight700,
                        ),
                      ),
                      const SizedBox(height: AppSizes.v3),
                      Text(
                        '${submission.brand}  •  ${submission.category}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const AppTextStyle(
                          fontSize: AppTypography.font9_5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSizes.v2),
                      Text(
                        'Submitted on ${submission.date}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const AppTextStyle(
                          fontSize: AppTypography.font8_5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.v5),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: compact ? AppSpacing.v6 : AppSpacing.sm,
                    vertical: AppSpacing.v5,
                  ),
                  decoration: BoxDecoration(
                    color: style.background,
                    borderRadius: BorderRadius.circular(AppRadii.card),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(style.icon, size: AppSizes.iconMicro, color: style.foreground),
                      const SizedBox(width: AppSizes.v4),
                      Text(
                        style.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle(
                          color: style.foreground,
                          fontSize: compact ? AppTypography.font8 : AppTypography.font8_5,
                          fontWeight: AppTypography.weight700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.v3),
                const Icon(
                  AppIcons.chevron_right,
                  size: AppSizes.iconControlTight,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatusStyle {
  const _StatusStyle(this.label, this.icon, this.foreground, this.background);

  final String label;
  final IconData icon;
  final Color foreground;
  final Color background;
}

_StatusStyle _statusStyle(SubmissionStatus status) {
  switch (status) {
    case SubmissionStatus.accepted:
      return const _StatusStyle(
        'Accepted',
        AppIcons.check_circle,
        AppColors.primary,
        AppColors.softGreen,
      );
    case SubmissionStatus.pending:
      return const _StatusStyle(
        'Pending',
        AppIcons.schedule,
        AppColors.amber,
        AppColors.softAmber,
      );
    case SubmissionStatus.rejected:
      return const _StatusStyle(
        'Rejected',
        AppIcons.cancel,
        AppColors.error,
        AppColors.softRed,
      );
    case SubmissionStatus.needsChange:
      return const _StatusStyle(
        'Needs Change',
        AppIcons.sync,
        AppColors.blue,
        AppColors.softBlue,
      );
  }
}

class _ContributionNote extends StatelessWidget {
  const _ContributionNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v13, vertical: AppSpacing.v10),
      decoration: BoxDecoration(
        color: AppColors.toneFFF2FAF5,
        borderRadius: BorderRadius.circular(AppRadii.chip),
        border: Border.all(color: AppColors.border),
      ),
      child: const Row(
        children: [
          Icon(AppIcons.eco_outlined, color: AppColors.primary, size: AppSizes.iconLg),
          SizedBox(width: AppSizes.v10),
          Expanded(
            child: Text(
              'Every submission counts. Together, we create a healthier tomorrow.',
              style: AppTextStyle(fontSize: AppTypography.font10_5, color: AppColors.textSecondary),
            ),
          ),
          Icon(AppIcons.favorite, color: AppColors.toneFF8BD67B, size: AppSizes.iconMediumTight),
        ],
      ),
    );
  }
}

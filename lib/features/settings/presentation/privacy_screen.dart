import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/main_bottom_navigation.dart';
import '../../auth/data/dummy_auth_service.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final email = DummyAuthService.instance.email;
    final compact = ResponsiveLayout.isCompact(context);

    return Scaffold(
      bottomNavigationBar: const MainBottomNavigation(
        currentDestination: MainNavigationDestination.profile,
      ),
      body: SafeArea(
        bottom: false,
        child: ResponsiveContent(
          maxWidth: AppSizes.contentLarge,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: ResponsiveLayout.pagePadding(
              context,
              compactHorizontal: AppSpacing.v14,
              phoneHorizontal: AppSpacing.xxl,
              tabletHorizontal: AppSpacing.v30,
              top: compact ? 16 : 20,
              bottom: AppSpacing.v18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: AppSizes.v40,
                        minHeight: AppSizes.v40,
                      ),
                      icon: Icon(
                        AppIcons.arrow_back,
                        size: compact ? AppSizes.v28 : AppSizes.v31,
                        color: AppColors.toneFF555B61,
                      ),
                    ),
                    const SizedBox(width: AppSizes.v10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Privacy',
                            style: AppTextStyles.pageTitleFor(compact: compact),
                          ),
                          const SizedBox(height: AppSizes.v8),
                          Text(
                            'See what we save and how it is used.',
                            style: AppTextStyle(
                              fontSize: compact ? AppTypography.font14 : AppTypography.font15_5,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: compact ? AppSizes.v46 : AppSizes.v52,
                      height: compact ? AppSizes.v46 : AppSizes.v52,
                      decoration: const BoxDecoration(
                        color: AppColors.softGreen,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        AppIcons.shield_outlined,
                        color: AppColors.primary,
                        size: compact ? AppSizes.v25 : AppSizes.v28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.v20),
                AppCard(
                  color: AppColors.surfaceSubtle,
                  padding: EdgeInsets.symmetric(
                    horizontal: compact ? AppSpacing.v14 : AppSpacing.v18,
                    vertical: compact ? AppSpacing.v14 : AppSpacing.lg,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        AppIcons.verified_user,
                        size: compact ? AppSizes.v48 : AppSizes.v56,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: compact ? AppSizes.v12 : AppSizes.v17),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your privacy is our priority',
                              style: compact
                                  ? AppTextStyles.sectionTitleSmall
                                  : AppTextStyles.sectionTitleMedium,
                            ),
                            const SizedBox(height: AppSizes.v5),
                            Text(
                              'We keep your personal data secure and only use it to improve your health scan experience.',
                              style: AppTextStyle(
                                fontSize: compact ? AppTypography.font12_5 : AppTypography.font13_5,
                                height: AppTypography.lineHeight1_35,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.v14),
                _PrivacyDataCard(
                  number: 1,
                  icon: AppIcons.mail_outline,
                  title: 'Saved email',
                  primaryText: email,
                  description:
                      'Used to secure your account and save scan history.',
                  onTap: () => _showMessage(context, 'Saved email selected.'),
                ),
                const SizedBox(height: AppSizes.v7),
                _PrivacyDataCard(
                  number: 2,
                  icon: AppIcons.phone_outlined,
                  title: 'Optional phone number',
                  primaryText: 'Not added',
                  description:
                      'Optional and used only if you add it for account recovery and notifications.',
                  onTap: () =>
                      _showMessage(context, 'Phone number selected.'),
                ),
                const SizedBox(height: AppSizes.v7),
                _PrivacyDataCard(
                  number: 3,
                  icon: AppIcons.monitor_heart_outlined,
                  title: 'Health concerns selected by user',
                  chips: const [
                    'Diabetes',
                    'Kidney concern',
                    'High blood pressure',
                  ],
                  description:
                      'Used to personalize alerts and product insights.',
                  onTap: () =>
                      _showMessage(context, 'Health concerns selected.'),
                ),
                const SizedBox(height: AppSizes.v7),
                _PrivacyDataCard(
                  number: 4,
                  icon: AppIcons.history,
                  title: 'Scan history',
                  primaryText: 'Previous scans are saved so you can',
                  description: 'review products later.',
                  onTap: () =>
                      _showMessage(context, 'Scan history selected.'),
                ),
                const SizedBox(height: AppSizes.v7),
                _PrivacyDataCard(
                  number: 5,
                  icon: AppIcons.description_outlined,
                  title: 'Correction submissions',
                  primaryText:
                      'Suggestions and uploaded correction details',
                  description:
                      'are saved so our review team can check them.',
                  onTap: () => _showMessage(
                    context,
                    'Correction submissions selected.',
                  ),
                ),
                const SizedBox(height: AppSizes.v10),
                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _PrivacyActionRow(
                        icon: AppIcons.person_outline,
                        title: 'Manage my data',
                        subtitle: 'View, update or remove your information.',
                        onTap: () =>
                            _showMessage(context, 'Manage data selected.'),
                      ),
                      _PrivacyActionRow(
                        icon: AppIcons.download_outlined,
                        title: 'Download my data',
                        subtitle: 'Get a copy of your data.',
                        onTap: () => _showMessage(
                          context,
                          'Demo data download started.',
                        ),
                      ),
                      _PrivacyActionRow(
                        icon: AppIcons.delete_outline,
                        title: 'Delete my data',
                        subtitle:
                            'Permanently delete your data from our system.',
                        iconColor: AppColors.error,
                        showDivider: false,
                        onTap: () => _showMessage(
                          context,
                          'No data was deleted in this frontend demo.',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.v10),
                const AppCard(
                  color: AppColors.surfaceSubtle,
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.v15, vertical: AppSpacing.v11),
                  child: Row(
                    children: [
                      Icon(
                        AppIcons.verified_user,
                        color: AppColors.primary,
                        size: AppSizes.iconDisplaySmall,
                      ),
                      SizedBox(width: AppSizes.v12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your information is never sold.',
                              style: AppTextStyle(
                                fontSize: AppTypography.font13,
                                fontWeight: AppTypography.weight800,
                              ),
                            ),
                            SizedBox(height: AppSizes.v2),
                            Text(
                              'We do not sell your personal health information to anyone.',
                              style: AppTextStyle(
                                fontSize: AppTypography.font10_5,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
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

class _PrivacyDataCard extends StatelessWidget {
  const _PrivacyDataCard({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.primaryText,
    this.chips,
  });

  final int number;
  final IconData icon;
  final String title;
  final String? primaryText;
  final List<String>? chips;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);

    return AppCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.v14),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            compact ? AppSpacing.md : AppSpacing.v15,
            AppSpacing.md,
            compact ? AppSpacing.v7 : AppSpacing.v10,
            AppSpacing.md,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: compact ? AppSizes.v42 : AppSizes.v48,
                height: compact ? AppSizes.v42 : AppSizes.v48,
                decoration: const BoxDecoration(
                  color: AppColors.softGreen,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: compact ? AppSizes.v24 : AppSizes.v27,
                ),
              ),
              SizedBox(width: compact ? AppSizes.v10 : AppSizes.v14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '$number. ',
                            style: const AppTextStyle(
                              fontWeight: AppTypography.weight800,
                            ),
                          ),
                          TextSpan(
                            text: title,
                            style: const AppTextStyle(
                              fontWeight: AppTypography.weight700,
                            ),
                          ),
                        ],
                      ),
                      style: AppTextStyle(
                        fontSize: compact ? AppTypography.font14_5 : AppTypography.font15_5,
                        height: AppTypography.lineHeight1_2,
                      ),
                    ),
                    if (primaryText != null) ...[
                      const SizedBox(height: AppSizes.v3),
                      Text(
                        primaryText!,
                        style: AppTextStyle(
                          fontSize: compact ? AppTypography.font12_5 : AppTypography.font13_5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                    if (chips != null) ...[
                      const SizedBox(height: AppSizes.v7),
                      Wrap(
                        spacing: 6,
                        runSpacing: 5,
                        children: chips!
                            .map(
                              (chip) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.v9,
                                  vertical: AppSpacing.v5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.softGreen,
                                  borderRadius: BorderRadius.circular(AppRadii.v15),
                                ),
                                child: Text(
                                  chip,
                                  style: const AppTextStyle(fontSize: AppTypography.font10_5),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                    const SizedBox(height: AppSizes.v4),
                    Text(
                      description,
                      style: AppTextStyle(
                        fontSize: compact ? AppTypography.font11_5 : AppTypography.font12_5,
                        height: AppTypography.lineHeight1_28,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.v17),
                child: Icon(
                  AppIcons.chevron_right,
                  color: AppColors.textSecondary,
                  size: compact ? AppSizes.v24 : AppSizes.v27,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrivacyActionRow extends StatelessWidget {
  const _PrivacyActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor = AppColors.primary,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color iconColor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: AppSizes.v58),
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.md : AppSpacing.v15,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(bottom: BorderSide(color: AppColors.divider))
              : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: compact ? AppSizes.v24 : AppSizes.v26),
            SizedBox(width: compact ? AppSizes.v12 : AppSizes.v15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyle(
                      fontSize: compact ? AppTypography.font13 : AppTypography.font13_5,
                      fontWeight: AppTypography.weight600,
                    ),
                  ),
                  const SizedBox(height: AppSizes.v2),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle(
                      fontSize: compact ? AppTypography.font10 : AppTypography.font10_5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              AppIcons.chevron_right,
              color: AppColors.textSecondary,
              size: AppSizes.iconLg,
            ),
          ],
        ),
      ),
    );
  }
}

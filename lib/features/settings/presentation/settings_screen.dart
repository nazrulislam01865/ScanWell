import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../core/widgets/app_button.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/main_bottom_navigation.dart';
import '../../auth/data/dummy_auth_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete account?'),
        content: const Text(
          'This is a frontend demo. No real account or data will be deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          AppButton(
            label: 'Delete',
            variant: AppButtonVariant.dangerText,
            size: AppButtonSize.compact,
            fullWidth: false,
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      if (!context.mounted) return;
      _showMessage(context, 'Demo account was not deleted.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = DummyAuthService.instance;
    final compact = ResponsiveLayout.isCompact(context);

    return Scaffold(
      bottomNavigationBar: const MainBottomNavigation(
        currentDestination: MainNavigationDestination.profile,
      ),
      body: SafeArea(
        bottom: false,
        child: ResponsiveContent(
          maxWidth: AppSizes.contentWide,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: ResponsiveLayout.pagePadding(
              context,
              compactHorizontal: AppSpacing.lg,
              phoneHorizontal: AppSpacing.xxl,
              tabletHorizontal: AppSpacing.v30,
              top: compact ? 18 : 23,
              bottom: AppSpacing.v22,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: AppTextStyles.profilePageTitleFor(compact: compact),
                ),
                const SizedBox(height: AppSizes.v8),
                Text(
                  'Manage your account and app preferences.',
                  style: AppTextStyles.profilePageBodyFor(compact: compact),
                ),
                SizedBox(height: compact ? AppSizes.v21 : AppSizes.v27),
                AppCard(
                  padding: EdgeInsets.symmetric(
                    horizontal: compact ? AppSpacing.v14 : AppSpacing.xl,
                    vertical: compact ? AppSpacing.v14 : AppSpacing.v18,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final veryCompact = constraints.maxWidth < AppBreakpoints.profileNarrow;
                      final avatarSize = veryCompact ? 56.0 : compact ? 64.0 : 76.0;

                      return Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              AppAssets.profileAminul,
                              width: avatarSize,
                              height: avatarSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: compact ? AppSizes.v12 : AppSizes.v18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  auth.displayName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.profileNameFor(compact: compact),
                                ),
                                const SizedBox(height: AppSizes.v4),
                                Text(
                                  auth.email,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.profileEmailFor(compact: compact),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: compact ? AppSizes.v6 : AppSizes.v10),
                          Material(
                            color: AppColors.softGreen,
                            shape: const CircleBorder(),
                            child: IconButton(
                              onPressed: () => _showMessage(
                                context,
                                'Profile editing is ready for API integration.',
                              ),
                              visualDensity: compact
                                  ? VisualDensity.compact
                                  : VisualDensity.standard,
                              icon: const Icon(
                                AppIcons.edit_outlined,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.v20),
                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _SettingsRow(
                        icon: AppIcons.person_outline,
                        label: 'Account',
                        onTap: () =>
                            _showMessage(context, 'Account settings selected.'),
                      ),
                      _SettingsRow(
                        icon: AppIcons.monitor_heart_outlined,
                        label: 'Health Profile',
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.personalizedAlerts,
                        ),
                      ),
                      _SettingsRow(
                        icon: AppIcons.language,
                        label: 'Language',
                        value: 'English',
                        onTap: () => _showMessage(context, 'Language selected.'),
                      ),
                      _SettingsRow(
                        icon: AppIcons.notifications_none,
                        label: 'Notifications',
                        value: 'On',
                        valueColor: AppColors.primary,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.personalizedAlerts,
                        ),
                      ),
                      _SettingsRow(
                        icon: AppIcons.shield_outlined,
                        label: 'Privacy',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.privacy),
                      ),
                      _SettingsRow(
                        icon: AppIcons.delete_outline,
                        label: 'Delete Account',
                        iconColor: AppColors.error,
                        labelColor: AppColors.error,
                        onTap: () => _confirmDelete(context),
                      ),
                      _SettingsRow(
                        icon: AppIcons.help_outline,
                        label: 'Help & FAQ',
                        onTap: () =>
                            _showMessage(context, 'Help & FAQ selected.'),
                      ),
                      _SettingsRow(
                        icon: AppIcons.info_outline,
                        label: 'About App',
                        showDivider: false,
                        onTap: () => _showMessage(
                          context,
                          'ScanWell frontend demo v1.0.0',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.v20),
                const AppCard(
                  color: AppColors.toneFFF8FCF9,
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.v15),
                  child: Row(
                    children: [
                      _ShieldBadge(),
                      SizedBox(width: AppSizes.v16),
                      Expanded(
                        child: Text(
                          'Your health information is private and secure.',
                          style: AppTextStyles.profilePrivacyNote,
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

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
    this.iconColor = AppColors.primary,
    this.labelColor = AppColors.textPrimary,
    this.valueColor = AppColors.textSecondary,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final String? value;
  final Color iconColor;
  final Color labelColor;
  final Color valueColor;
  final bool showDivider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: AppSizes.v64),
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.v14 : AppSpacing.xl,
          vertical: compact ? AppSpacing.v11 : AppSpacing.md,
        ),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(bottom: BorderSide(color: AppColors.divider))
              : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: compact ? AppSizes.v27 : AppSizes.v31),
            SizedBox(width: compact ? AppSizes.v14 : AppSizes.v20),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  maxLines: 1,
                  softWrap: false,
                  style: AppTextStyles.profileMenuLabelFor(compact: compact).copyWith(
                    color: labelColor,
                  ),
                ),
              ),
            ),
            if (value != null) ...[
              const SizedBox(width: AppSizes.v8),
              Text(
                value!,
                maxLines: 1,
                softWrap: false,
                style: AppTextStyles.profileMenuValueFor(compact: compact).copyWith(
                  color: valueColor,
                ),
              ),
              const SizedBox(width: AppSizes.v6),
            ],
            const Icon(
              AppIcons.chevron_right,
              size: AppSizes.iconNavigation,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _ShieldBadge extends StatelessWidget {
  const _ShieldBadge();

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);
    final size = compact ? 50.0 : 58.0;

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.softGreenStrong,
        shape: BoxShape.circle,
      ),
      child: Icon(
        AppIcons.verified_user,
        color: AppColors.primary,
        size: compact ? AppSizes.v31 : AppSizes.v36,
      ),
    );
  }
}

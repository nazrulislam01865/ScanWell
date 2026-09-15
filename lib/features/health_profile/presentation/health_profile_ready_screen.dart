import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/app_button.dart';
import '../widgets/health_setup_header.dart';

class HealthProfileReadyScreen extends StatelessWidget {
  const HealthProfileReadyScreen({super.key});

  void _finish(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < AppBreakpoints.comfortablePhone;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveContent(
          maxWidth: AppSizes.contentMedium,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              compact ? AppSpacing.v18 : AppSpacing.xxxl,
              AppSpacing.v5,
              compact ? AppSpacing.v18 : AppSpacing.xxxl,
              AppSpacing.v28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HealthSetupHeader(
                  step: 3,
                  onBack: () => Navigator.maybePop(context),
                ),
                SizedBox(height: compact ? AppSpacing.v20 : AppSpacing.xl),
                Center(
                  child: Container(
                    width: compact ? AppSizes.v92 : AppSizes.v104,
                    height: compact ? AppSizes.v92 : AppSizes.v104,
                    decoration: const BoxDecoration(
                      color: AppColors.softGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      AppIcons.verified_user_rounded,
                      color: AppColors.primary,
                      size: compact ? AppSizes.v50 : AppSizes.v58,
                    ),
                  ),
                ),
                SizedBox(height: compact ? AppSpacing.v16 : AppSpacing.v20),
                Text(
                  'Your health profile is ready',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.preDashboardTitleFor(compact: compact),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'ScanWell can now use your selected health concerns to show more relevant product alerts and warnings.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.preDashboardBodyFor(compact: compact),
                ),
                SizedBox(height: compact ? AppSpacing.v20 : AppSpacing.xl),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: compact ? AppSpacing.lg : AppSpacing.xl,
                    vertical: compact ? AppSpacing.lg : AppSpacing.xl,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.toneFFF7FCF8,
                    borderRadius: BorderRadius.circular(AppRadii.xl),
                    border: Border.all(color: AppColors.toneFFBCE0C8),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        AppIcons.notifications_rounded,
                        color: AppColors.primary,
                        size: AppSizes.iconFeature,
                      ),
                      SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Personalized alerts are enabled',
                              style: AppTextStyles.preDashboardCardTitle,
                            ),
                            SizedBox(height: AppSpacing.xs),
                            Text(
                              'You can review or update your health profile later from Profile.',
                              style: AppTextStyles.preDashboardSupporting,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: compact ? AppSpacing.v20 : AppSpacing.xl),
                AppButton(
                  label: 'Go to Dashboard',
                  buttonKey: const Key('finish-health-setup'),
                  size: AppButtonSize.preDashboard,
                  emphasis: AppButtonEmphasis.standard,
                  onPressed: () => _finish(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

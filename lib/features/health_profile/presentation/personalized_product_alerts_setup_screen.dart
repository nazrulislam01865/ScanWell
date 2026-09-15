import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/app_button.dart';
import '../widgets/health_setup_header.dart';

class PersonalizedProductAlertsSetupScreen extends StatefulWidget {
  const PersonalizedProductAlertsSetupScreen({super.key});

  @override
  State<PersonalizedProductAlertsSetupScreen> createState() =>
      _PersonalizedProductAlertsSetupScreenState();
}

class _PersonalizedProductAlertsSetupScreenState
    extends State<PersonalizedProductAlertsSetupScreen> {
  final Set<String> _selected = <String>{
    'Diabetes',
    'High blood pressure',
    'Asthma',
  };

  static const List<_HealthConcern> _concerns = <_HealthConcern>[
    _HealthConcern('Diabetes', AppIcons.water_drop_rounded),
    _HealthConcern('High blood pressure', AppIcons.monitor_heart_rounded),
    _HealthConcern('Kidney concern', AppIcons.bubble_chart_rounded),
    _HealthConcern('Liver concern', AppIcons.spa_rounded),
    _HealthConcern('Asthma', AppIcons.air_rounded),
    _HealthConcern('Heart concern', AppIcons.favorite_rounded),
    _HealthConcern('Food allergy', AppIcons.eco_rounded),
    _HealthConcern('High cholesterol', AppIcons.opacity_rounded),
    _HealthConcern('Pregnancy', AppIcons.pregnant_woman_rounded),
    _HealthConcern('Child nutrition', AppIcons.child_care_rounded),
  ];

  void _toggle(String label) {
    setState(() {
      if (_selected.contains(label)) {
        _selected.remove(label);
      } else {
        _selected.add(label);
      }
    });
  }

  void _skipSetup() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  void _continue() {
    Navigator.pushNamed(context, AppRoutes.addHealthConcern);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < AppBreakpoints.comfortablePhone;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HealthSetupHeader(
                  step: 1,
                  onBack: () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.signup,
                  ),
                ),
                SizedBox(height: compact ? AppSpacing.v16 : AppSpacing.v20),
                Text(
                  'Do you want personalized product alerts?',
                  style: AppTextStyles.preDashboardTitleFor(compact: compact),
                ),
                const SizedBox(height: AppSpacing.v8),
                Text(
                  'Select your health concerns so we can show more relevant warnings when you scan a product.',
                  style: AppTextStyles.preDashboardBodyFor(compact: compact),
                ),
                SizedBox(height: compact ? AppSpacing.v14 : AppSpacing.v18),
                _PersonalizedInfoCard(compact: compact),
                const SizedBox(height: AppSizes.v18),
                _ConcernGrid(
                  concerns: _concerns,
                  selected: _selected,
                  onToggle: _toggle,
                ),
                const SizedBox(height: AppSizes.v12),
                _HealthConcernTile(
                  concern: const _HealthConcern(
                    'Other',
                    AppIcons.more_horiz_rounded,
                  ),
                  selected: _selected.contains('Other'),
                  fullWidth: true,
                  onTap: () => _toggle('Other'),
                ),
                SizedBox(height: compact ? AppSpacing.v14 : AppSpacing.v18),
                AppButton(
                  label: 'Continue',
                  buttonKey: const Key('personalized-alerts-continue'),
                  size: AppButtonSize.preDashboard,
                  emphasis: AppButtonEmphasis.standard,
                  onPressed: _continue,
                ),
                const SizedBox(height: AppSizes.v9),
                Center(
                  child: AppButton(
                    label: 'Skip for now',
                    variant: AppButtonVariant.text,
                    size: AppButtonSize.preDashboard,
                    emphasis: AppButtonEmphasis.standard,
                    fullWidth: false,
                    onPressed: _skipSetup,
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

class _PersonalizedInfoCard extends StatelessWidget {
  const _PersonalizedInfoCard({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? AppSpacing.lg : AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.toneFFFCFFFD,
        borderRadius: BorderRadius.circular(AppRadii.xxl),
        border: Border.all(color: AppColors.toneFFD9E7DE),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final narrowCard = constraints.maxWidth < AppBreakpoints.narrowContent;

          final copy = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: compact ? AppSizes.v43 : AppSizes.v47,
                    height: compact ? AppSizes.v43 : AppSizes.v47,
                    decoration: const BoxDecoration(
                      color: AppColors.toneFFE7F7EC,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      AppIcons.notifications_rounded,
                      color: AppColors.primary,
                      size: AppSizes.iconActionLarge,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      'Personalized for you',
                      maxLines: 2,
                      style: AppTextStyles.preDashboardCardTitle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'We’ll notify you about products that may not be right for your health concerns.',
                style: AppTextStyles.preDashboardSupporting,
              ),
            ],
          );

          final illustration = Image.asset(
            AppAssets.healthAlertsIllustration,
            width: narrowCard
                ? AppSizes.v120
                : compact
                    ? AppSizes.v112
                    : AppSizes.v138,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          );

          if (narrowCard) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                copy,
                const SizedBox(height: AppSpacing.md),
                Align(alignment: Alignment.centerRight, child: illustration),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 3, child: copy),
              const SizedBox(width: AppSpacing.sm),
              Flexible(flex: 2, child: illustration),
            ],
          );
        },
      ),
    );
  }
}

class _ConcernGrid extends StatelessWidget {
  const _ConcernGrid({
    required this.concerns,
    required this.selected,
    required this.onToggle,
  });

  final List<_HealthConcern> concerns;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < AppBreakpoints.narrowContent
            ? 1
            : 2;
        final spacing = constraints.maxWidth < AppBreakpoints.denseContent
            ? AppSpacing.sm
            : AppSpacing.md;
        final itemWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: concerns
              .map(
                (concern) => SizedBox(
                  width: itemWidth,
                  child: _HealthConcernTile(
                    concern: concern,
                    selected: selected.contains(concern.label),
                    onTap: () => onToggle(concern.label),
                  ),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

class _HealthConcernTile extends StatelessWidget {
  const _HealthConcernTile({
    required this.concern,
    required this.selected,
    required this.onTap,
    this.fullWidth = false,
  });

  final _HealthConcern concern;
  final bool selected;
  final VoidCallback onTap;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < AppBreakpoints.comfortablePhone;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: AnimatedContainer(
          duration: AppMotion.ms150,
          width: fullWidth ? double.infinity : null,
          constraints: BoxConstraints(
            minHeight: compact ? AppSizes.v68 : AppSizes.v70,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: compact ? AppSpacing.sm : AppSpacing.v12,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? AppSizes.v1_2 : AppSizes.v1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: compact ? AppSizes.v36 : AppSizes.v42,
                height: compact ? AppSizes.v36 : AppSizes.v42,
                decoration: BoxDecoration(
                  color: concern.label == 'Other'
                      ? AppColors.toneFFF2F3F4
                      : AppColors.toneFFEAF8EF,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  concern.icon,
                  color: concern.label == 'Other'
                      ? AppColors.textPrimary
                      : AppColors.primary,
                  size: compact ? AppSizes.iconMd : AppSizes.v25,
                ),
              ),
              SizedBox(width: compact ? AppSpacing.v6 : AppSpacing.sm),
              Expanded(
                child: Text(
                  concern.label,
                  maxLines: 2,
                  softWrap: true,
                  style: AppTextStyles.preDashboardSectionTitle,
                ),
              ),
              SizedBox(width: compact ? AppSpacing.xs : AppSpacing.v6),
              _SelectionBox(selected: selected, compact: compact),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionBox extends StatelessWidget {
  const _SelectionBox({required this.selected, required this.compact});

  final bool selected;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? AppSizes.v22 : AppSizes.v25;

    return AnimatedContainer(
      duration: AppMotion.ms140,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.circular(AppRadii.xs),
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.toneFFB5BBC2,
          width: AppSizes.v1_4,
        ),
      ),
      child: selected
          ? Icon(
              AppIcons.check_rounded,
              color: AppColors.white,
              size: compact ? AppSizes.iconSm : AppSizes.iconMediumTight,
            )
          : null,
    );
  }
}

class _HealthConcern {
  const _HealthConcern(this.label, this.icon);

  final String label;
  final IconData icon;
}

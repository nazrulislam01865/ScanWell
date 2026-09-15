import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/app_button.dart';
import '../widgets/health_setup_header.dart';

class AddHealthConcernScreen extends StatefulWidget {
  const AddHealthConcernScreen({super.key});

  @override
  State<AddHealthConcernScreen> createState() => _AddHealthConcernScreenState();
}

class _AddHealthConcernScreenState extends State<AddHealthConcernScreen> {
  final _concernController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _concernController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_concernController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Please enter your health concern.')),
        );
      return;
    }

    Navigator.pushNamed(context, AppRoutes.healthProfileReady);
  }

  void _skip() {
    Navigator.pushNamed(context, AppRoutes.healthProfileReady);
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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              compact ? AppSpacing.v18 : AppSpacing.xxxl,
              AppSpacing.v5,
              compact ? AppSpacing.v18 : AppSpacing.xxxl,
              AppSpacing.v26,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HealthSetupHeader(
                  step: 2,
                  onBack: () => Navigator.maybePop(context),
                ),
                SizedBox(height: compact ? AppSpacing.v16 : AppSpacing.v20),
                _AddConcernHero(compact: compact),
                SizedBox(height: compact ? AppSpacing.v18 : AppSpacing.xl),
                const _FieldLabel(label: 'Health concern', isRequired: true),
                const SizedBox(height: AppSpacing.sm),
                _LargeInput(
                  fieldKey: const Key('health-concern-input'),
                  controller: _concernController,
                  hintText: 'Type your health concern',
                  icon: AppIcons.monitor_heart_outlined,
                  minLines: 2,
                  maxLines: 3,
                ),
                const SizedBox(height: AppSpacing.v18),
                const _FieldLabel(label: 'Note (optional)'),
                const SizedBox(height: AppSpacing.sm),
                _LargeInput(
                  controller: _noteController,
                  hintText: 'Add a short note if needed',
                  icon: AppIcons.description_outlined,
                  minLines: 4,
                  maxLines: 5,
                ),
                const SizedBox(height: AppSpacing.v18),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.v18,
                    vertical: AppSpacing.v16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.toneFFF7FCF8,
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                    border: Border.all(color: AppColors.toneFFBCE0C8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: AppSizes.v36,
                        height: AppSizes.v36,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          AppIcons.info_rounded,
                          color: AppColors.white,
                          size: AppSizes.iconControlLarge,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'New concerns are reviewed before they are added.',
                          style: AppTextStyles.preDashboardSupporting.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: AppTypography.weight500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.v18),
                AppButton(
                  label: 'Submit for review',
                  buttonKey: const Key('submit-health-concern'),
                  size: AppButtonSize.preDashboard,
                  emphasis: AppButtonEmphasis.standard,
                  onPressed: _submit,
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: AppButton(
                    label: 'Skip for now',
                    buttonKey: const Key('skip-health-concern'),
                    variant: AppButtonVariant.text,
                    size: AppButtonSize.preDashboard,
                    emphasis: AppButtonEmphasis.standard,
                    fullWidth: false,
                    onPressed: _skip,
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

class _AddConcernHero extends StatelessWidget {
  const _AddConcernHero({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < AppBreakpoints.denseContent;
        final text = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add another health concern',
              style: AppTextStyles.preDashboardTitleFor(compact: compact),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Tell us the condition you want us to consider when showing product warnings.',
              style: AppTextStyles.preDashboardBodyFor(compact: compact),
            ),
          ],
        );

        final image = Image.asset(
          AppAssets.addConcernIllustration,
          width: narrow
              ? AppSizes.v120
              : compact
                  ? AppSizes.v126
                  : AppSizes.v170,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        );

        if (narrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              text,
              const SizedBox(height: AppSpacing.md),
              Align(alignment: Alignment.centerRight, child: image),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 3, child: text),
            const SizedBox(width: AppSpacing.sm),
            Flexible(flex: 2, child: image),
          ],
        );
      },
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, this.isRequired = false});

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: label,
        style: AppTextStyles.authFieldLabel,
        children: isRequired
            ? const [
                TextSpan(
                  text: ' *',
                  style: AppTextStyle(color: AppColors.toneFFE12D39),
                ),
              ]
            : const [],
      ),
    );
  }
}

class _LargeInput extends StatelessWidget {
  const _LargeInput({
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.minLines,
    required this.maxLines,
    this.fieldKey,
  });

  final Key? fieldKey;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: fieldKey,
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      textAlignVertical: TextAlignVertical.top,
      style: AppTextStyles.authInputText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.authInputHint.copyWith(
          color: AppColors.toneFF8B9098,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.v15,
            right: AppSpacing.md,
            bottom: AppSpacing.v34,
          ),
          child: Icon(
            icon,
            color: AppColors.toneFF68717A,
            size: AppSizes.iconFeature,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: AppSizes.v56),
        contentPadding: const EdgeInsets.fromLTRB(
          AppSpacing.none,
          AppSpacing.v18,
          AppSpacing.v15,
          AppSpacing.v18,
        ),
        filled: true,
        fillColor: AppColors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
          borderSide: const BorderSide(color: AppColors.toneFFD8DADD),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: AppSizes.v1_3,
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../widgets/workflow_app_bar.dart';
import '../widgets/workflow_section_card.dart';

class ProcessingProductScreen extends StatefulWidget {
  const ProcessingProductScreen({super.key});

  @override
  State<ProcessingProductScreen> createState() => _ProcessingProductScreenState();
}

class _ProcessingProductScreenState extends State<ProcessingProductScreen> {
  Timer? _completionTimer;

  @override
  void initState() {
    super.initState();
    _completionTimer = Timer(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.possibleDuplicate);
    });
  }

  @override
  void dispose() {
    _completionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).height < 760;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ResponsiveContent(
          maxWidth: AppSizes.contentMedium,
          child: Column(
            children: [
              WorkflowAppBar(
                title: 'Processing product',
                onBack: () => Navigator.maybePop(context),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.v22,
                    compact ? AppSpacing.v10 : AppSpacing.v18,
                    AppSpacing.v22,
                    AppSpacing.xxl,
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadii.v17),
                        child: AspectRatio(
                          aspectRatio: 1.7,
                          child: Image.asset(
                            AppAssets.granolaProcessingWorkflow,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: compact ? AppSizes.v16 : AppSizes.v23),
                      const _ProcessingIntro(),
                      SizedBox(height: compact ? AppSizes.v15 : AppSizes.v20),
                      const _ProgressCard(),
                      SizedBox(height: compact ? AppSizes.v14 : AppSizes.v18),
                      const _ProcessingSteps(),
                      const SizedBox(height: AppSizes.v17),
                      const _PrivacyMessage(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProcessingIntro extends StatelessWidget {
  const _ProcessingIntro();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: AppSizes.v54,
          height: AppSizes.v54,
          decoration: const BoxDecoration(
            color: AppColors.softGreenStrong,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            AppIcons.auto_awesome_rounded,
            color: AppColors.primary,
            size: AppSizes.iconNavigation,
          ),
        ),
        const SizedBox(width: AppSizes.v15),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This may take a few seconds.',
                style: AppTextStyle(
                  fontSize: AppTypography.font18,
                  height: AppTypography.lineHeight1_1,
                  fontWeight: AppTypography.weight800,
                ),
              ),
              SizedBox(height: AppSizes.v5),
              Text(
                'We’re analyzing the label and preparing your result.',
                style: AppTextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppTypography.font13_5,
                  height: AppTypography.lineHeight1_3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return WorkflowSectionCard(
      padding: const EdgeInsets.all(AppSpacing.v18),
      child: Row(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.18, end: 0.68),
            duration: AppMotion.ms1600,
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return SizedBox(
                width: AppSizes.v104,
                height: AppSizes.v104,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: AppSizes.v8,
                        backgroundColor: AppColors.toneFFE1F1E6,
                        color: AppColors.primary,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Text(
                      '${(value * 100).round()}%',
                      style: const AppTextStyle(
                        color: AppColors.primaryDark,
                        fontSize: AppTypography.font30,
                        fontWeight: AppTypography.weight800,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: AppSizes.v24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Processing...',
                  style: AppTextStyle(fontSize: AppTypography.font18, fontWeight: AppTypography.weight800),
                ),
                const SizedBox(height: AppSizes.v13),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadii.chip),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.22, end: 0.68),
                    duration: AppMotion.ms1600,
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) {
                      return LinearProgressIndicator(
                        value: value,
                        minHeight: AppSizes.v13,
                        backgroundColor: AppColors.toneFFE6F4E9,
                        color: AppColors.primary,
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.v13),
                const Text(
                  'Almost there! Thank you for your patience.',
                  style: AppTextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTypography.font12_5,
                    height: AppTypography.lineHeight1_25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcessingSteps extends StatelessWidget {
  const _ProcessingSteps();

  @override
  Widget build(BuildContext context) {
    const steps = <_ProcessingStepData>[
      _ProcessingStepData(
        title: 'Reading image',
        icon: AppIcons.image_outlined,
        state: _ProcessingState.complete,
      ),
      _ProcessingStepData(
        title: 'Extracting text',
        icon: AppIcons.text_fields_rounded,
        state: _ProcessingState.complete,
      ),
      _ProcessingStepData(
        title: 'Detecting nutrition table',
        icon: AppIcons.table_chart_outlined,
        state: _ProcessingState.processing,
      ),
      _ProcessingStepData(
        title: 'Checking product database',
        icon: AppIcons.storage_outlined,
        state: _ProcessingState.pending,
      ),
      _ProcessingStepData(
        title: 'Preparing health flags',
        icon: AppIcons.flag_outlined,
        state: _ProcessingState.pending,
      ),
    ];

    return WorkflowSectionCard(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.v10, AppSpacing.lg, AppSpacing.v10),
      child: Column(
        children: List.generate(
          steps.length,
          (index) => _ProcessingStep(
            number: index + 1,
            data: steps[index],
            showDivider: index != steps.length - 1,
          ),
        ),
      ),
    );
  }
}

enum _ProcessingState { complete, processing, pending }

class _ProcessingStepData {
  const _ProcessingStepData({
    required this.title,
    required this.icon,
    required this.state,
  });

  final String title;
  final IconData icon;
  final _ProcessingState state;
}

class _ProcessingStep extends StatelessWidget {
  const _ProcessingStep({
    required this.number,
    required this.data,
    required this.showDivider,
  });

  final int number;
  final _ProcessingStepData data;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final active = data.state != _ProcessingState.pending;

    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.v23,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (showDivider)
                  Positioned(
                    top: AppSpacing.v31,
                    bottom: AppSpacing.n13,
                    child: Container(
                      width: AppSizes.v2,
                      color: active
                          ? AppColors.primary.withOpacity(AppOpacity.v0_6)
                          : AppColors.toneFFD9DDDA,
                    ),
                  ),
                Container(
                  width: AppSizes.v10,
                  height: AppSizes.v10,
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.primary
                        : AppColors.toneFFD8DCD9,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.v6),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.v10),
              decoration: showDivider
                  ? const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.divider),
                      ),
                    )
                  : null,
              child: Row(
                children: [
                  Container(
                    width: AppSizes.v42,
                    height: AppSizes.v42,
                    decoration: BoxDecoration(
                      color: active
                          ? AppColors.softGreenStrong
                          : AppColors.toneFFF2F4F3,
                      borderRadius: BorderRadius.circular(AppRadii.chip),
                    ),
                    child: Icon(
                      data.icon,
                      color: active
                          ? AppColors.primaryDark
                          : AppColors.textSecondary,
                      size: AppSizes.iconActionLarge,
                    ),
                  ),
                  const SizedBox(width: AppSizes.v13),
                  Expanded(
                    child: Text(
                      '$number. ${data.title}',
                      style: AppTextStyle(
                        color: data.state == _ProcessingState.processing
                            ? AppColors.primaryDark
                            : AppColors.textPrimary,
                        fontSize: AppTypography.font16,
                        fontWeight: data.state == _ProcessingState.processing
                            ? AppTypography.weight700
                            : AppTypography.weight500,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.v10),
                  _StepStatusIcon(state: data.state),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepStatusIcon extends StatelessWidget {
  const _StepStatusIcon({required this.state});

  final _ProcessingState state;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case _ProcessingState.complete:
        return const Icon(
          AppIcons.check_circle_rounded,
          color: AppColors.primary,
          size: AppSizes.iconHero,
        );
      case _ProcessingState.processing:
        return const SizedBox(
          width: AppSizes.v30,
          height: AppSizes.v30,
          child: CircularProgressIndicator(
            strokeWidth: AppSizes.v4,
            color: AppColors.primary,
            backgroundColor: AppColors.softGreenStrong,
          ),
        );
      case _ProcessingState.pending:
        return Container(
          width: AppSizes.v30,
          height: AppSizes.v30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.toneFFCFD4D1, width: AppSizes.v2),
          ),
        );
    }
  }
}

class _PrivacyMessage extends StatelessWidget {
  const _PrivacyMessage();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(AppIcons.shield_outlined, color: AppColors.primary, size: AppSizes.iconHero),
        SizedBox(width: AppSizes.v11),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Your data is private and secure.\n',
                  style: AppTextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: AppTypography.weight600,
                  ),
                ),
                TextSpan(
                  text: 'We don’t store images of your products.',
                  style: AppTextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
            style: AppTextStyle(fontSize: AppTypography.font12_5, height: AppTypography.lineHeight1_35),
          ),
        ),
      ],
    );
  }
}

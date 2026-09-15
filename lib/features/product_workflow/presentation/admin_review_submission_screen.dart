import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../core/widgets/app_button.dart';

import '../../../core/layout/responsive_layout.dart';
import '../data/demo_product_workflow_data.dart';
import '../data/product_workflow_models.dart';
import '../widgets/workflow_app_bar.dart';
import '../widgets/workflow_section_card.dart';

class AdminReviewSubmissionScreen extends StatefulWidget {
  const AdminReviewSubmissionScreen({super.key});

  @override
  State<AdminReviewSubmissionScreen> createState() =>
      _AdminReviewSubmissionScreenState();
}

class _AdminReviewSubmissionScreenState
    extends State<AdminReviewSubmissionScreen> {
  final TextEditingController _commentController = TextEditingController();
  AdminDecision? _decision;
  bool _notDuplicate = false;

  bool get _canSubmit =>
      _decision != null && _commentController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitDecision() {
    final decision = _decision;
    if (decision == null) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('${decision.label} decision submitted.')),
      );
    Navigator.maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ResponsiveContent(
          maxWidth: AppSizes.contentXLarge,
          child: Column(
            children: [
              WorkflowAppBar(
                title: 'Review Submission',
                subtitle: 'Product data review',
                centerTitle: false,
                onBack: () => Navigator.maybePop(context),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(AppIcons.bookmark_border_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(AppIcons.more_horiz_rounded),
                  ),
                ],
                showDivider: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    compact ? AppSpacing.v14 : AppSpacing.xl,
                    AppSpacing.v14,
                    compact ? AppSpacing.v14 : AppSpacing.xl,
                    AppSpacing.v28,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SubmissionSummary(),
                      const SizedBox(height: AppSizes.v16),
                      const _OriginalImagesSection(),
                      const SizedBox(height: AppSizes.v16),
                      const _ExtractedProductDataSection(),
                      const SizedBox(height: AppSizes.v16),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth >= 520) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(child: _HealthFlagsSection()),
                                const SizedBox(width: AppSizes.v14),
                                Expanded(
                                  child: _DuplicateSection(
                                    notDuplicate: _notDuplicate,
                                    onChanged: (value) => setState(
                                      () => _notDuplicate = value ?? false,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                          return Column(
                            children: [
                              const _HealthFlagsSection(),
                              const SizedBox(height: AppSizes.v14),
                              _DuplicateSection(
                                notDuplicate: _notDuplicate,
                                onChanged: (value) => setState(
                                  () => _notDuplicate = value ?? false,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: AppSizes.v17),
                      _AdminDecisionSection(
                        selected: _decision,
                        onSelected: (decision) => setState(
                          () => _decision = decision,
                        ),
                      ),
                      const SizedBox(height: AppSizes.v17),
                      _CommentSection(
                        controller: _commentController,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: AppSizes.v12),
                      const _AuditNotice(),
                      const SizedBox(height: AppSizes.v20),
                      Row(
                        children: [
                          SizedBox(
                            width: AppSizes.v104,
                            child: AppButton(
                              label: 'Back',
                              variant: AppButtonVariant.outlineNeutral,
                              size: AppButtonSize.admin,
                              onPressed: () => Navigator.maybePop(context),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: compact ? AppSizes.v170 : AppSizes.v230,
                            child: AppButton(
                              label: 'Submit Decision',
                              size: AppButtonSize.admin,
                              onPressed: _canSubmit ? _submitDecision : null,
                            ),
                          ),
                        ],
                      ),
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

extension on AdminDecision {
  String get label {
    switch (this) {
      case AdminDecision.approve:
        return 'Approve';
      case AdminDecision.reject:
        return 'Reject';
      case AdminDecision.requestChanges:
        return 'Request Changes';
      case AdminDecision.merge:
        return 'Merge';
    }
  }

  String get subtitle {
    switch (this) {
      case AdminDecision.approve:
        return 'Add to database';
      case AdminDecision.reject:
        return 'Do not add';
      case AdminDecision.requestChanges:
        return 'Needs more info';
      case AdminDecision.merge:
        return 'With existing product';
    }
  }

  IconData get icon {
    switch (this) {
      case AdminDecision.approve:
        return AppIcons.check_circle_outline_rounded;
      case AdminDecision.reject:
        return AppIcons.cancel_outlined;
      case AdminDecision.requestChanges:
        return AppIcons.edit_note_rounded;
      case AdminDecision.merge:
        return AppIcons.merge_type_rounded;
    }
  }

  Color get color {
    switch (this) {
      case AdminDecision.approve:
        return AppColors.primary;
      case AdminDecision.reject:
        return AppColors.toneFFD84D55;
      case AdminDecision.requestChanges:
        return AppColors.amber;
      case AdminDecision.merge:
        return AppColors.purple;
    }
  }

  Color get background {
    switch (this) {
      case AdminDecision.approve:
        return AppColors.softGreen;
      case AdminDecision.reject:
        return AppColors.toneFFFFF3F4;
      case AdminDecision.requestChanges:
        return AppColors.warningSurfaceMuted;
      case AdminDecision.merge:
        return AppColors.softPurple;
    }
  }
}

class _SubmissionSummary extends StatelessWidget {
  const _SubmissionSummary();

  @override
  Widget build(BuildContext context) {
    const items = <_SummaryItemData>[
      _SummaryItemData(
        label: 'Submission Type',
        value: 'New Product',
        icon: AppIcons.inventory_2_outlined,
        valueColor: AppColors.primaryDark,
      ),
      _SummaryItemData(
        label: 'Submitted By',
        value: 'Aminur Rahman\nVolunteer',
        icon: AppIcons.person_outline_rounded,
      ),
      _SummaryItemData(
        label: 'Submitted Date',
        value: 'May 18, 2025\n10:24 AM',
        icon: AppIcons.calendar_today_outlined,
      ),
      _SummaryItemData(
        label: 'OCR Confidence',
        value: '92%\nHigh',
        icon: AppIcons.verified_outlined,
        valueColor: AppColors.primary,
      ),
    ];

    return WorkflowSectionCard(
      padding: EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / items.length;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                items.length,
                (index) => Container(
                  width: itemWidth.clamp(AppSizes.v122, 180.0).toDouble(),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: index == items.length - 1
                      ? null
                      : const BoxDecoration(
                          border: Border(
                            right: BorderSide(color: AppColors.divider),
                          ),
                        ),
                  child: _SummaryItem(data: items[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SummaryItemData {
  const _SummaryItemData({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor = AppColors.textPrimary,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color valueColor;
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.data});

  final _SummaryItemData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.label,
          style: const AppTextStyle(
            color: AppColors.textSecondary,
            fontSize: AppTypography.font10_5,
            fontWeight: AppTypography.weight500,
          ),
        ),
        const SizedBox(height: AppSizes.v8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AppSizes.v30,
              height: AppSizes.v30,
              decoration: const BoxDecoration(
                color: AppColors.softGreen,
                shape: BoxShape.circle,
              ),
              child: Icon(data.icon, color: AppColors.primaryDark, size: AppSizes.iconFine),
            ),
            const SizedBox(width: AppSizes.v8),
            Expanded(
              child: Text(
                data.value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle(
                  color: data.valueColor,
                  fontSize: AppTypography.font11_5,
                  height: AppTypography.lineHeight1_3,
                  fontWeight: AppTypography.weight700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OriginalImagesSection extends StatelessWidget {
  const _OriginalImagesSection();

  @override
  Widget build(BuildContext context) {
    const images = <String>[
      AppAssets.laysFrontReviewWorkflow,
      AppAssets.laysBackReviewWorkflow,
      AppAssets.laysIngredientsReviewWorkflow,
      AppAssets.laysNutritionReviewWorkflow,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _NumberedTitle(number: 1, title: 'Original Product Images'),
        const SizedBox(height: AppSizes.v10),
        SizedBox(
          height: AppSizes.v142,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSizes.v10),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(AppRadii.v7),
                child: Image.asset(
                  images[index],
                  width: AppSizes.v112,
                  height: AppSizes.v142,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSizes.v7),
        const Row(
          children: [
            Icon(AppIcons.fullscreen_rounded, size: AppSizes.iconFine, color: AppColors.textSecondary),
            SizedBox(width: AppSizes.v5),
            Text(
              'Tap to view full size',
              style: AppTextStyle(
                color: AppColors.textSecondary,
                fontSize: AppTypography.font10_5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ExtractedProductDataSection extends StatelessWidget {
  const _ExtractedProductDataSection();

  @override
  Widget build(BuildContext context) {
    const left = <MapEntry<String, String>>[
      MapEntry('Product Name', 'Lay’s American Style Cream & Onion'),
      MapEntry('Brand', 'Lay’s'),
      MapEntry('Category', 'Snacks > Potato Chips'),
      MapEntry('Net Weight', '28 g'),
      MapEntry('Country of Origin', 'India'),
      MapEntry('Barcode', '8901491029008'),
    ];
    const right = <MapEntry<String, String>>[
      MapEntry('Serving Size', '28 g (About 15 Chips)'),
      MapEntry('Calories', '160 kcal'),
      MapEntry('Sugar', '1 g'),
      MapEntry('Sodium', '200 mg'),
      MapEntry('Total Fat', '10 g'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _NumberedTitle(number: 2, title: 'Extracted Product Data'),
        const SizedBox(height: AppSizes.v10),
        WorkflowSectionCard(
          padding: const EdgeInsets.all(AppSpacing.v13),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 470) {
                return Column(
                  children: [
                    _DataColumn(items: left),
                    const Divider(height: AppSizes.v22),
                    _DataColumn(items: right),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: _DataColumn(items: left)),
                  Container(
                    width: AppSizes.v1,
                    height: AppSizes.v138,
                    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    color: AppColors.divider,
                  ),
                  const Expanded(child: _DataColumn(items: right)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DataColumn extends StatelessWidget {
  const _DataColumn({required this.items});

  final List<MapEntry<String, String>> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.v7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppSizes.v92,
                  child: Text(
                    item.key,
                    style: const AppTextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppTypography.font10_5,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.v7),
                Expanded(
                  child: Text(
                    item.value,
                    style: const AppTextStyle(
                      fontSize: AppTypography.font10_5,
                      fontWeight: AppTypography.weight500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: AppButton(
            label: 'View All Extracted Data',
            icon: AppIcons.chevron_right_rounded,
            iconAlignment: IconAlignment.end,
            variant: AppButtonVariant.text,
            size: AppButtonSize.tiny,
            fullWidth: false,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class _HealthFlagsSection extends StatelessWidget {
  const _HealthFlagsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _NumberedTitle(number: 3, title: 'Detected Health Flags'),
        const SizedBox(height: AppSizes.v10),
        ...reviewHealthFlags.map(
          (flag) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _HealthFlagCard(flag: flag),
          ),
        ),
        AppButton(
          label: 'View All Health Flags',
          icon: AppIcons.chevron_right_rounded,
          iconAlignment: IconAlignment.end,
          variant: AppButtonVariant.text,
          size: AppButtonSize.tiny,
          fullWidth: false,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _HealthFlagCard extends StatelessWidget {
  const _HealthFlagCard({required this.flag});

  final HealthReviewFlag flag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.v11),
      decoration: BoxDecoration(
        color: flag.background,
        borderRadius: BorderRadius.circular(AppRadii.chip),
        border: Border.all(color: flag.color.withOpacity(AppOpacity.v0_18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(flag.icon, color: flag.color, size: AppSizes.iconProfileAction),
          const SizedBox(width: AppSizes.v11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  flag.title,
                  style: const AppTextStyle(
                    fontSize: AppTypography.font11_5,
                    fontWeight: AppTypography.weight800,
                  ),
                ),
                const SizedBox(height: AppSizes.v3),
                Text(
                  flag.description,
                  style: const AppTextStyle(fontSize: AppTypography.font9_5, height: AppTypography.lineHeight1_25),
                ),
                Text(
                  flag.value,
                  style: const AppTextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTypography.font9_2,
                    height: AppTypography.lineHeight1_25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.v8),
          StatusBadge(
            label: flag.level,
            foreground: flag.color,
            background: flag.background,
          ),
        ],
      ),
    );
  }
}

class _DuplicateSection extends StatelessWidget {
  const _DuplicateSection({
    required this.notDuplicate,
    required this.onChanged,
  });

  final bool notDuplicate;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: _NumberedTitle(
                number: 4,
                title: 'Possible Duplicate Match',
              ),
            ),
            const StatusBadge(
              label: '87% Match',
              foreground: AppColors.purple,
              background: AppColors.softPurple,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.v10),
        const Text(
          'This product looks similar to an existing product in our database.',
          style: AppTextStyle(fontSize: AppTypography.font10_5, height: AppTypography.lineHeight1_4),
        ),
        const SizedBox(height: AppSizes.v10),
        WorkflowSectionCard(
          padding: const EdgeInsets.all(AppSpacing.v11),
          child: Row(
            children: [
              Image.asset(
                AppAssets.productLays,
                width: AppSizes.v70,
                height: AppSizes.v88,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: AppSizes.v10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lay’s Cream & Onion',
                      style: AppTextStyle(
                        fontSize: AppTypography.font11_5,
                        fontWeight: AppTypography.weight800,
                      ),
                    ),
                    SizedBox(height: AppSizes.v4),
                    Text('Lay’s', style: AppTextStyle(fontSize: AppTypography.font10)),
                    SizedBox(height: AppSizes.v7),
                    Text(
                      'Snacks > Potato Chips\n28 g',
                      style: AppTextStyle(
                        color: AppColors.textSecondary,
                        fontSize: AppTypography.font9_5,
                        height: AppTypography.lineHeight1_3,
                      ),
                    ),
                  ],
                ),
              ),
              const StatusBadge(
                label: 'Active',
                foreground: AppColors.primary,
                background: AppColors.softGreen,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.v9),
        const Text(
          'Last updated: Mar 10, 2025\nMatch based on name, brand, nutrition and ingredients.',
          style: AppTextStyle(
            color: AppColors.textSecondary,
            fontSize: AppTypography.font9_5,
            height: AppTypography.lineHeight1_35,
          ),
        ),
        const SizedBox(height: AppSizes.v10),
        AppButton(
          label: 'View Product Details',
          icon: AppIcons.open_in_new_rounded,
          iconAlignment: IconAlignment.end,
          variant: AppButtonVariant.purpleOutline,
          size: AppButtonSize.adminCompact,
          onPressed: () {},
        ),
        CheckboxListTile(
          value: notDuplicate,
          onChanged: onChanged,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
          visualDensity: VisualDensity.compact,
          title: const Text(
            'This is not a duplicate',
            style: AppTextStyle(fontSize: AppTypography.font10_5),
          ),
        ),
      ],
    );
  }
}

class _AdminDecisionSection extends StatelessWidget {
  const _AdminDecisionSection({
    required this.selected,
    required this.onSelected,
  });

  final AdminDecision? selected;
  final ValueChanged<AdminDecision> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _NumberedTitle(number: 5, title: 'Admin Decision'),
        const SizedBox(height: AppSizes.v10),
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = constraints.maxWidth >= 600
                ? (constraints.maxWidth - 30) / 4
                : 155.0;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: AdminDecision.values
                    .map(
                      (decision) => Padding(
                        padding: EdgeInsets.only(
                          right: decision == AdminDecision.values.last ? AppSpacing.none : AppSpacing.v10,
                        ),
                        child: SizedBox(
                          width: cardWidth,
                          child: _DecisionCard(
                            decision: decision,
                            selected: selected == decision,
                            onTap: () => onSelected(decision),
                          ),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _DecisionCard extends StatelessWidget {
  const _DecisionCard({
    required this.decision,
    required this.selected,
    required this.onTap,
  });

  final AdminDecision decision;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: decision.background,
      borderRadius: BorderRadius.circular(AppRadii.chip),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.chip),
        child: Container(
          height: AppSizes.v74,
          padding: const EdgeInsets.all(AppSpacing.v10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.chip),
            border: Border.all(
              color: selected ? decision.color : decision.color.withOpacity(AppOpacity.v0_2),
              width: selected ? AppSizes.v1_6 : AppSizes.v1,
            ),
          ),
          child: Row(
            children: [
              Icon(decision.icon, color: decision.color, size: AppSizes.iconActionLarge),
              const SizedBox(width: AppSizes.v9),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      decision.label,
                      style: AppTextStyle(
                        color: decision.color,
                        fontSize: AppTypography.font11_5,
                        fontWeight: AppTypography.weight800,
                      ),
                    ),
                    const SizedBox(height: AppSizes.v2),
                    Text(
                      decision.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const AppTextStyle(
                        color: AppColors.textSecondary,
                        fontSize: AppTypography.font9_3,
                        height: AppTypography.lineHeight1_2,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Icon(AppIcons.check_circle_rounded, color: decision.color, size: AppSizes.iconCompact),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentSection extends StatelessWidget {
  const _CommentSection({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _NumberedTitle(number: 6, title: 'Admin Comment (Required)'),
        const SizedBox(height: AppSizes.v10),
        TextField(
          controller: controller,
          onChanged: onChanged,
          minLines: 4,
          maxLines: 6,
          maxLength: 1000,
          decoration: InputDecoration(
            hintText: 'Add comments about your decision...',
            hintStyle: const AppTextStyle(fontSize: AppTypography.font12),
            contentPadding: const EdgeInsets.all(AppSpacing.v13),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.chip),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.chip),
              borderSide: const BorderSide(color: AppColors.primary, width: AppSizes.v1_3),
            ),
          ),
        ),
      ],
    );
  }
}

class _AuditNotice extends StatelessWidget {
  const _AuditNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.v10),
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(AppRadii.v7),
        border: Border.all(color: AppColors.toneFFDCEAF2),
      ),
      child: const Row(
        children: [
          Icon(AppIcons.info_outline_rounded, color: AppColors.blue, size: AppSizes.iconCompact),
          SizedBox(width: AppSizes.v8),
          Expanded(
            child: Text(
              'Your decision and comments will be recorded for audit and quality purposes.',
              style: AppTextStyle(
                color: AppColors.textSecondary,
                fontSize: AppTypography.font10_5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberedTitle extends StatelessWidget {
  const _NumberedTitle({required this.number, required this.title});

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$number. $title',
      style: const AppTextStyle(
        color: AppColors.textPrimary,
        fontSize: AppTypography.font13,
        fontWeight: AppTypography.weight800,
      ),
    );
  }
}

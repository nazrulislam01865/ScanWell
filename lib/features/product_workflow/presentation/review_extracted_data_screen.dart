import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/primary_button.dart';
import '../data/demo_product_workflow_data.dart';
import '../data/product_workflow_models.dart';
import '../widgets/workflow_app_bar.dart';
import '../widgets/workflow_section_card.dart';

class ReviewExtractedDataScreen extends StatefulWidget {
  const ReviewExtractedDataScreen({super.key});

  @override
  State<ReviewExtractedDataScreen> createState() =>
      _ReviewExtractedDataScreenState();
}

class _ReviewExtractedDataScreenState extends State<ReviewExtractedDataScreen> {
  late List<ExtractedField> _productFields;
  late List<ExtractedField> _nutritionFields;
  late TextEditingController _ingredientsController;

  @override
  void initState() {
    super.initState();
    _productFields = List<ExtractedField>.of(productInformationSection.fields);
    _nutritionFields = List<ExtractedField>.of(nutritionInformationSection.fields);
    _ingredientsController = TextEditingController(text: extractedIngredients);
  }

  @override
  void dispose() {
    _ingredientsController.dispose();
    super.dispose();
  }

  Future<void> _editField({
    required bool nutrition,
    required int index,
  }) async {
    final fields = nutrition ? _nutritionFields : _productFields;
    final field = fields[index];
    final controller = TextEditingController(text: field.value);

    final value = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Edit ${field.label}'),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: field.label == 'Manufacturer' ? 2 : 1,
            decoration: InputDecoration(labelText: field.label),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(
                dialogContext,
                controller.text.trim(),
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    controller.dispose();
    if (value == null || value.isEmpty || !mounted) return;

    setState(() {
      fields[index] = field.copyWith(value: value);
    });
  }

  void _submit() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Product submitted for admin review.')),
      );
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.dashboard,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ResponsiveContent(
          maxWidth: AppSizes.contentStandard,
          child: Column(
            children: [
              WorkflowAppBar(
                title: 'Review Extracted Data',
                onBack: () => Navigator.maybePop(context),
              ),
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    compact ? AppSpacing.v14 : AppSpacing.xl,
                    AppSpacing.none,
                    compact ? AppSpacing.v14 : AppSpacing.xl,
                    AppSpacing.xl,
                  ),
                  child: Column(
                    children: [
                      const _LowConfidenceNotice(),
                      const SizedBox(height: AppSizes.v10),
                      const _ScannedImageCard(),
                      const SizedBox(height: AppSizes.v12),
                      _EditableFieldSection(
                        index: 1,
                        title: productInformationSection.title,
                        icon: productInformationSection.icon,
                        fields: _productFields,
                        onEdit: (index) => _editField(
                          nutrition: false,
                          index: index,
                        ),
                      ),
                      const SizedBox(height: AppSizes.v12),
                      _EditableFieldSection(
                        index: 2,
                        title: nutritionInformationSection.title,
                        icon: nutritionInformationSection.icon,
                        fields: _nutritionFields,
                        onEdit: (index) => _editField(
                          nutrition: true,
                          index: index,
                        ),
                      ),
                      const SizedBox(height: AppSizes.v12),
                      _IngredientsSection(controller: _ingredientsController),
                      const SizedBox(height: AppSizes.v16),
                      PrimaryButton(
                        label: 'Submit for Review',
                        onPressed: _submit,
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

class _LowConfidenceNotice extends StatelessWidget {
  const _LowConfidenceNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v14, vertical: AppSpacing.v10),
      color: AppColors.toneFFF8FAF9,
      child: const Row(
        children: [
          Icon(AppIcons.circle, size: AppSizes.iconSm, color: AppColors.toneFFFFD34D),
          SizedBox(width: AppSizes.v10),
          Expanded(
            child: Text(
              'Yellow-highlighted fields are low-confidence OCR results.',
              style: AppTextStyle(
                color: AppColors.textSecondary,
                fontSize: AppTypography.font12,
                height: AppTypography.lineHeight1_2,
              ),
            ),
          ),
          SizedBox(width: AppSizes.v8),
          Icon(
            AppIcons.info_outline_rounded,
            color: AppColors.primaryDark,
            size: AppSizes.iconMediumTight,
          ),
        ],
      ),
    );
  }
}

class _ScannedImageCard extends StatelessWidget {
  const _ScannedImageCard();

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return WorkflowSectionCard(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppSpacing.v14 : AppSpacing.xxl,
        vertical: compact ? AppSpacing.v13 : AppSpacing.lg,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.v7),
            child: Image.asset(
              AppAssets.granolaExtractedWorkflow,
              width: compact ? AppSizes.v82 : AppSizes.v100,
              height: compact ? AppSizes.v100 : AppSizes.v118,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: compact ? AppSizes.v15 : AppSizes.v28),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Image from scan',
                  style: AppTextStyle(
                    color: AppColors.primaryDark,
                    fontSize: AppTypography.font14,
                    fontWeight: AppTypography.weight700,
                  ),
                ),
                SizedBox(height: AppSizes.v9),
                Text(
                  'Captured on May 18, 2025 at 9:35 AM',
                  style: AppTextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTypography.font12,
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

class _EditableFieldSection extends StatelessWidget {
  const _EditableFieldSection({
    required this.index,
    required this.title,
    required this.icon,
    required this.fields,
    required this.onEdit,
  });

  final int index;
  final String title;
  final IconData icon;
  final List<ExtractedField> fields;
  final ValueChanged<int> onEdit;

  @override
  Widget build(BuildContext context) {
    return WorkflowSectionCard(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
      child: Column(
        children: [
          WorkflowSectionTitle(index: index, title: title, icon: icon),
          const SizedBox(height: AppSizes.v10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: List.generate(
                fields.length,
                (fieldIndex) => _EditableFieldRow(
                  field: fields[fieldIndex],
                  showDivider: fieldIndex != fields.length - 1,
                  onEdit: () => onEdit(fieldIndex),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditableFieldRow extends StatelessWidget {
  const _EditableFieldRow({
    required this.field,
    required this.showDivider,
    required this.onEdit,
  });

  final ExtractedField field;
  final bool showDivider;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Container(
      constraints: const BoxConstraints(minHeight: AppSizes.v36),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppSpacing.v10 : AppSpacing.v13,
        vertical: AppSpacing.v7,
      ),
      decoration: BoxDecoration(
        color: field.lowConfidence
            ? AppColors.toneFFFFF9D9
            : AppColors.white,
        border: showDivider
            ? const Border(
                bottom: BorderSide(color: AppColors.divider),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              field.label,
              style: AppTextStyle(
                fontSize: compact ? AppTypography.font11_5 : AppTypography.font12_5,
                height: AppTypography.lineHeight1_2,
                fontWeight: AppTypography.weight500,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.v10),
          Expanded(
            flex: 6,
            child: Text(
              field.value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle(
                fontSize: compact ? AppTypography.font11_5 : AppTypography.font12_5,
                height: AppTypography.lineHeight1_2,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.v5),
          IconButton(
            onPressed: onEdit,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: AppSizes.v31, height: AppSizes.v31),
            icon: const Icon(
              AppIcons.edit_outlined,
              color: AppColors.primaryDark,
              size: AppSizes.iconCompact,
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientsSection extends StatelessWidget {
  const _IngredientsSection({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return WorkflowSectionCard(
      padding: const EdgeInsets.fromLTRB(AppSpacing.v14, AppSpacing.v13, AppSpacing.v14, AppSpacing.v14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WorkflowSectionTitle(
            index: 3,
            title: 'Ingredients',
            icon: AppIcons.eco_outlined,
          ),
          const SizedBox(height: AppSizes.v6),
          const Text(
            'Editable text',
            style: AppTextStyle(
              color: AppColors.primaryDark,
              fontSize: AppTypography.font11_5,
              fontWeight: AppTypography.weight700,
            ),
          ),
          const SizedBox(height: AppSizes.v7),
          TextField(
            controller: controller,
            minLines: 4,
            maxLines: 6,
            style: const AppTextStyle(fontSize: AppTypography.font12_5, height: AppTypography.lineHeight1_45),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.all(AppSpacing.v13),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.chip),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.chip),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: AppSizes.v1_3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

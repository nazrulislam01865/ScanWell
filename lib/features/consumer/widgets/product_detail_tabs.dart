import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../data/product_detail_data.dart';

class ProductDetailTabs extends StatelessWidget {
  const ProductDetailTabs({
    required this.selectedTab,
    required this.onTabSelected,
    this.rounded = false,
    super.key,
  });

  final ProductDetailTab selectedTab;
  final ValueChanged<ProductDetailTab> onTabSelected;
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: rounded
            ? const BorderRadius.vertical(top: Radius.circular(AppRadii.v18))
            : BorderRadius.zero,
        border: const Border(
          top: BorderSide(color: AppColors.subtleDivider),
          bottom: BorderSide(color: AppColors.subtleDivider),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: ProductDetailTab.values
            .map(
              (tab) => Expanded(
                child: _ProductDetailTabItem(
                  tab: tab,
                  selected: selectedTab == tab,
                  onTap: () => onTabSelected(tab),
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _ProductDetailTabItem extends StatelessWidget {
  const _ProductDetailTabItem({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  final ProductDetailTab tab;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;
    final color = selected ? AppColors.primary : AppColors.toneFF555D65;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: compact ? AppSizes.v62 : AppSizes.v66,
        child: Column(
          children: [
            const SizedBox(height: AppSizes.v9),
            Icon(
              tab.icon,
              color: color,
              size: compact ? AppSizes.v21 : AppSizes.v22,
            ),
            const SizedBox(height: AppSizes.v5),
            Text(
              tab.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.productDetailTabFor(
                compact: compact,
                selected: selected,
                color: color,
              ),
            ),
            const Spacer(),
            AnimatedContainer(
              duration: AppMotion.ms160,
              width: double.infinity,
              height: selected ? AppSizes.v3 : AppSizes.v0,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.sm)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

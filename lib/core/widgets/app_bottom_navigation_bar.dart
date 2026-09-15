import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../layout/responsive_layout.dart';

class AppBottomNavigationItem {
  const AppBottomNavigationItem({
    required this.label,
    required this.icon,
    this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData? activeIcon;
}

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.highlightIndex,
    super.key,
  });

  final List<AppBottomNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int? highlightIndex;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final compact = ResponsiveLayout.isCompact(context);
    final height = ((compact ? 68.0 : 72.0) +
            ((textScale - 1).clamp(0.0, 1.0) * 12))
        .toDouble();

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: height,
          child: Row(
            children: List.generate(
              items.length,
              (index) => Expanded(
                child: _NavigationItem(
                  item: items[index],
                  selected: currentIndex == index,
                  compact: compact,
                  highlighted: highlightIndex == index,
                  onTap: () => onTap(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.item,
    required this.selected,
    required this.compact,
    required this.highlighted,
    required this.onTap,
  });

  final AppBottomNavigationItem item;
  final bool selected;
  final bool compact;
  final bool highlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.toneFF656B72;

    return Semantics(
      selected: selected,
      button: true,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
          child: Column(
            children: [
              AnimatedContainer(
                duration: AppMotion.ms180,
                width: compact ? AppSizes.v35 : AppSizes.v45,
                height: AppSizes.v2_5,
                color: selected ? AppColors.primary : AppColors.transparent,
              ),
              const Spacer(),
              if (highlighted && !selected)
                Container(
                  width: compact ? AppSizes.v38 : AppSizes.v42,
                  height: compact ? AppSizes.v38 : AppSizes.v42,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.activeIcon ?? item.icon,
                    color: AppColors.white,
                    size: compact ? AppSizes.v23 : AppSizes.v25,
                  ),
                )
              else
                Icon(
                  selected ? item.activeIcon ?? item.icon : item.icon,
                  color: color,
                  size: compact ? AppSizes.v23 : AppSizes.v25,
                ),
              const SizedBox(height: AppSizes.v4),
              SizedBox(
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    item.label,
                    maxLines: 1,
                    style: AppTextStyle(
                      color: color,
                      fontSize: compact ? AppTypography.font9_5 : AppTypography.font10_5,
                      fontWeight:
                          selected ? AppTypography.weight700 : AppTypography.weight500,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

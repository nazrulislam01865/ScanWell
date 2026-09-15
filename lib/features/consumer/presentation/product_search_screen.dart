import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/main_bottom_navigation.dart';
import '../data/consumer_product.dart';
import '../data/demo_consumer_data.dart';
import '../widgets/health_flag_badge.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  bool _verifiedOnly = false;

  List<ConsumerProduct> get _visibleProducts {
    final normalized = _query.trim().toLowerCase();
    return searchableProducts.where((product) {
      final matchesQuery = normalized.isEmpty ||
          product.name.toLowerCase().contains(normalized) ||
          product.brand.toLowerCase().contains(normalized);
      final matchesVerified = !_verifiedOnly || product.adminVerified;
      return matchesQuery && matchesVerified;
    }).toList(growable: false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;
    final products = _visibleProducts;

    return Scaffold(
      bottomNavigationBar: const MainBottomNavigation(
        currentDestination: MainNavigationDestination.search,
      ),
      body: SafeArea(
        bottom: false,
        child: ResponsiveContent(
          maxWidth: AppSizes.contentWide,
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: ResponsiveLayout.pagePadding(
                  context,
                  compactHorizontal: AppSpacing.v13,
                  phoneHorizontal: AppSpacing.v19,
                  tabletHorizontal: AppSpacing.v28,
                  top: compact ? 15 : 22,
                  bottom: AppSpacing.v18,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    const _SearchTitle(),
                    SizedBox(height: compact ? AppSizes.v14 : AppSizes.v17),
                    _SearchField(
                      controller: _searchController,
                      onChanged: (value) => setState(() => _query = value),
                      onScanBarcode: () => _showMessage(
                        'Barcode scanner is ready for camera integration.',
                      ),
                    ),
                    const SizedBox(height: AppSizes.v14),
                    _FilterBar(
                      verifiedOnly: _verifiedOnly,
                      onVerifiedChanged: (value) =>
                          setState(() => _verifiedOnly = value),
                      onFilterTap: (filter) =>
                          _showMessage('$filter filter is ready for API integration.'),
                    ),
                    const SizedBox(height: AppSizes.v13),
                    if (products.isEmpty)
                      const _EmptySearchResult()
                    else
                      ...List.generate(
                        products.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                            bottom: index == products.length - AppSpacing.v1 ? AppSpacing.none : AppSpacing.v9,
                          ),
                          child: _SearchProductCard(
                            product: products[index],
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.productDetail,
                            ),
                          ),
                        ),
                      ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchTitle extends StatelessWidget {
  const _SearchTitle();

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;
    return Row(
      children: [
        SizedBox(
          width: compact ? AppSizes.v50 : AppSizes.v56,
          height: compact ? AppSizes.v38 : AppSizes.v42,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: AppSpacing.v7,
                child: Transform.rotate(
                  angle: -0.55,
                  child: Icon(
                    AppIcons.eco_rounded,
                    color: AppColors.toneFF2D9D12,
                    size: compact ? AppSizes.v29 : AppSizes.v33,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: AppSpacing.v1,
                child: Transform.rotate(
                  angle: 0.50,
                  child: Icon(
                    AppIcons.eco_rounded,
                    color: AppColors.toneFF197A0B,
                    size: compact ? AppSizes.v31 : AppSizes.v35,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSizes.v9),
        Expanded(
          child: Text(
            'Product Search',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.pageTitleFor(
              compact: compact,
              variant: AppPageTitleVariant.search,
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onScanBarcode,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onScanBarcode;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      style: AppTextStyle(fontSize: compact ? AppTypography.font14 : AppTypography.font15_5),
      decoration: InputDecoration(
        hintText: 'Search by product name, brand, or barcode',
        hintStyle: AppTextStyle(
          color: AppColors.toneFF777C82,
          fontSize: compact ? AppTypography.font13 : AppTypography.font15,
          fontWeight: AppTypography.weight400,
        ),
        prefixIcon: Icon(
          AppIcons.search_rounded,
          color: AppColors.primaryDark,
          size: compact ? AppSizes.v27 : AppSizes.v30,
        ),
        suffixIcon: IconButton(
          tooltip: 'Scan barcode',
          onPressed: onScanBarcode,
          icon: Icon(
            AppIcons.qr_code_scanner_rounded,
            color: AppColors.primaryDark,
            size: compact ? AppSizes.v29 : AppSizes.v33,
          ),
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(vertical: compact ? AppSpacing.v13 : AppSpacing.v17),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.v15),
          borderSide: const BorderSide(color: AppColors.focusRing, width: AppSizes.v1_3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.v15),
          borderSide: const BorderSide(color: AppColors.primary, width: AppSizes.v1_8),
        ),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.verifiedOnly,
    required this.onVerifiedChanged,
    required this.onFilterTap,
  });

  final bool verifiedOnly;
  final ValueChanged<bool> onVerifiedChanged;
  final ValueChanged<String> onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 9,
      runSpacing: 9,
      children: [
        _FilterChipButton(
          icon: AppIcons.grid_view_rounded,
          label: 'Category',
          showChevron: true,
          onTap: () => onFilterTap('Category'),
        ),
        _FilterChipButton(
          icon: AppIcons.sell_outlined,
          label: 'Brand',
          showChevron: true,
          onTap: () => onFilterTap('Brand'),
        ),
        _FilterChipButton(
          icon: AppIcons.health_and_safety_outlined,
          label: 'Health flag',
          showChevron: true,
          onTap: () => onFilterTap('Health flag'),
        ),
        _FilterChipButton(
          icon: verifiedOnly
              ? AppIcons.verified_user_rounded
              : AppIcons.verified_user_outlined,
          label: 'Verified only',
          selected: verifiedOnly,
          onTap: () => onVerifiedChanged(!verifiedOnly),
        ),
        _FilterChipButton(
          icon: AppIcons.person_outline_rounded,
          label: 'Suitable for my profile',
          showChevron: true,
          onTap: () => onFilterTap('Health profile'),
        ),
      ],
    );
  }
}

class _FilterChipButton extends StatelessWidget {
  const _FilterChipButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.showChevron = false,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showChevron;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;
    return Material(
      color: selected ? AppColors.softGreenStrong : AppColors.white,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.card),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? AppSpacing.v10 : AppSpacing.md,
            vertical: compact ? AppSpacing.v9 : AppSpacing.v10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.toneFFD9E1D7,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: AppColors.primaryDark,
                size: compact ? AppSizes.v18 : AppSizes.v20,
              ),
              const SizedBox(width: AppSizes.v7),
              Text(
                label,
                style: AppTextStyle(
                  color: AppColors.successTextStrong,
                  fontSize: compact ? AppTypography.font11_5 : AppTypography.font12_5,
                  fontWeight: AppTypography.weight500,
                ),
              ),
              if (showChevron) ...[
                const SizedBox(width: AppSizes.v6),
                Icon(
                  AppIcons.keyboard_arrow_down_rounded,
                  color: AppColors.successTextStrong,
                  size: compact ? AppSizes.v17 : AppSizes.v18,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchProductCard extends StatelessWidget {
  const _SearchProductCard({
    required this.product,
    required this.onTap,
  });

  final ConsumerProduct product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppRadii.v15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.v15),
        child: Container(
          constraints: BoxConstraints(minHeight: compact ? AppSizes.v128 : AppSizes.v145),
          padding: EdgeInsets.fromLTRB(
            compact ? AppSpacing.v10 : AppSpacing.v15,
            compact ? AppSpacing.v10 : AppSpacing.md,
            compact ? AppSpacing.v9 : AppSpacing.v13,
            compact ? AppSpacing.v10 : AppSpacing.md,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.v15),
            border: Border.all(color: AppColors.border),
            boxShadow: AppShadows.searchCard,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: compact ? AppSizes.v82 : AppSizes.v112,
                height: compact ? AppSizes.v108 : AppSizes.v125,
                child: Image.asset(product.imageAsset, fit: BoxFit.contain),
              ),
              SizedBox(width: compact ? AppSizes.v9 : AppSizes.v14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle(
                              fontSize: compact ? AppTypography.font15_5 : AppTypography.font18,
                              height: AppTypography.lineHeight1_08,
                              fontWeight: AppTypography.weight800,
                              letterSpacing: AppTypography.letterSpacingn0_25,
                            ),
                          ),
                        ),
                        if (product.adminVerified && !compact) ...[
                          const SizedBox(width: AppSizes.v7),
                          const _AdminVerifiedBadge(),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSizes.v4),
                    Text(
                      product.brand,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle(
                        color: AppColors.textSecondary,
                        fontSize: compact ? AppTypography.font11_5 : AppTypography.font13,
                      ),
                    ),
                    if (product.adminVerified && compact) ...[
                      const SizedBox(height: AppSizes.v6),
                      const _AdminVerifiedBadge(),
                    ],
                    const SizedBox(height: AppSizes.v7),
                    HealthFlagBadge(
                      flag: product.healthFlag,
                      compact: compact,
                    ),
                    const SizedBox(height: AppSizes.v7),
                    Row(
                      children: [
                        Transform.rotate(
                          angle: -0.45,
                          child: Icon(
                            AppIcons.eco_rounded,
                            size: compact ? AppSizes.v16 : AppSizes.v18,
                            color: AppColors.toneFF71C96A,
                          ),
                        ),
                        const SizedBox(width: AppSizes.v5),
                        Expanded(
                          child: Text(
                            product.insight,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle(
                              color: AppColors.textSecondary,
                              fontSize: compact ? AppTypography.font10_5 : AppTypography.font12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminVerifiedBadge extends StatelessWidget {
  const _AdminVerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.v6),
      decoration: BoxDecoration(
        color: AppColors.toneFFF0F9EA,
        borderRadius: BorderRadius.circular(AppRadii.v6),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            AppIcons.verified_user_outlined,
            size: AppSizes.iconSm,
            color: AppColors.primaryDark,
          ),
          SizedBox(width: AppSizes.v5),
          Text(
            'Admin Verified',
            style: AppTextStyle(
              color: AppColors.toneFF276D2B,
              fontSize: AppTypography.font10_5,
              fontWeight: AppTypography.weight600,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptySearchResult extends StatelessWidget {
  const _EmptySearchResult();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl, vertical: AppSpacing.huge),
      decoration: BoxDecoration(
        color: AppColors.softGreen,
        borderRadius: BorderRadius.circular(AppRadii.v15),
        border: Border.all(color: AppColors.toneFFDCEDE2),
      ),
      child: const Column(
        children: [
          Icon(AppIcons.search_off_rounded, size: AppSizes.iconEmptyState, color: AppColors.primary),
          SizedBox(height: AppSizes.v12),
          Text(
            'No products found',
            style: AppTextStyle(fontSize: AppTypography.font17, fontWeight: AppTypography.weight700),
          ),
          SizedBox(height: AppSizes.v5),
          Text(
            'Try a different product name or turn off “Verified only”.',
            textAlign: TextAlign.center,
            style: AppTextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

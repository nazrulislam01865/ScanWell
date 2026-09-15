import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

/// Shared breakpoints and sizing helpers used throughout the app.
///
/// The UI keeps the original mobile composition, while constraining content on
/// tablets and allowing compact phones to use smaller safe padding.
class ResponsiveLayout {
  ResponsiveLayout._();
  static const double compactPhone = AppBreakpoints.compactPhone;
  static const double tablet = AppBreakpoints.tablet;

  static bool isCompact(BuildContext context) {
    return MediaQuery.sizeOf(context).width < compactPhone;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).shortestSide >= tablet;
  }

  static double value(
    BuildContext context, {
    required double compact,
    required double phone,
    required double tablet,
  }) {
    if (isTablet(context)) return tablet;
    if (isCompact(context)) return compact;
    return phone;
  }

  static EdgeInsets pagePadding(
    BuildContext context, {
    double compactHorizontal = AppSpacing.lg,
    double phoneHorizontal = AppSpacing.v22,
    double tabletHorizontal = AppSpacing.xxxl,
    double top = AppSpacing.none,
    double bottom = AppSpacing.none,
  }) {
    return EdgeInsets.fromLTRB(
      value(
        context,
        compact: compactHorizontal,
        phone: phoneHorizontal,
        tablet: tabletHorizontal,
      ),
      top,
      value(
        context,
        compact: compactHorizontal,
        phone: phoneHorizontal,
        tablet: tabletHorizontal,
      ),
      bottom,
    );
  }
}

/// Centers a page on large screens without changing the intended phone design.
class ResponsiveContent extends StatelessWidget {
  const ResponsiveContent({
    required this.child,
    this.maxWidth = AppBreakpoints.contentMaxWidth,
    this.alignment = Alignment.topCenter,
    super.key,
  });

  final Widget child;
  final double maxWidth;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

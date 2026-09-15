/// Central responsive breakpoints used by ScanWell layouts.
///
/// Feature code should depend on these semantic thresholds instead of embedding
/// width literals. Changing a breakpoint here updates every participating page.
abstract final class AppBreakpoints {
  AppBreakpoints._();

  /// Micro content areas where inline banners must stack.
  static const double microContent = 270;

  /// Very narrow profile cards with reduced avatar sizing.
  static const double profileNarrow = 285;

  /// Extremely narrow content areas that need stacked compositions.
  static const double narrowContent = 300;

  /// Small content areas where two-column controls need tighter spacing.
  static const double denseContent = 330;

  /// Product detail health score switches to a stacked composition below this content width.
  static const double productDetailHealthStack = 340;

  /// Product detail bottom actions stack below this content width.
  static const double productDetailActionsStack = 350;

  /// Dashboard cards use tighter gutters below this width.
  static const double dashboardTight = 340;

  /// Dense submission rows simplify their trailing content below this width.
  static const double submissionCompact = 350;

  /// Compact phone breakpoint used by shared page padding and controls.
  static const double compactPhone = 360;

  /// Phone widths below this threshold use the compact health/dashboard layout.
  static const double comfortablePhone = 390;

  /// Standard tablet threshold.
  static const double tablet = 600;

  /// Width where dashboard card families can fit all cards in one row without scrolling.
  static const double dashboardCardsInline = 450;

  /// Content width at which dashboard cards can use their desktop column count.
  static const double dashboardWide = 620;

  /// Default maximum width for centered content.
  static const double contentMaxWidth = 620;
}

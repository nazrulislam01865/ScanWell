import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

enum AppButtonVariant {
  primary,
  primaryRounded,
  primaryDetail,
  primaryElevated,
  success,
  outline,
  outlineStrong,
  outlineRounded,
  outlineCompact,
  outlineDetail,
  outlineTight,
  outlineNeutral,
  duplicateOutline,
  text,
  textStrong,
  dangerText,
  inverseText,
  warningOutline,
  purpleOutline,
  cameraPrimary,
  cameraOutline,
}

enum AppButtonSize {
  micro,
  toolbar,
  tiny,
  inline,
  sectionAction,
  gallery,
  compact,
  small,
  adminCompact,
  admin,
  medium,
  detailCompact,
  detail,
  productDetailAction,
  actionBarCompact,
  actionBar,
  large,
  preDashboard,
  prominent,
  review,
  extraLarge,
  profileCompact,
  authCompact,
  auth,
  camera,
  profile,
  jumbo,
}

enum AppButtonEmphasis { standard, strong, heavy }

/// Central button component for repeated button families.
///
/// Feature screens choose semantic [variant] and [size] values instead of
/// rebuilding colors, radii, typography, padding and disabled state locally.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.large,
    this.icon,
    this.iconSize,
    this.iconAlignment = IconAlignment.start,
    this.fullWidth = true,
    this.fitLabel = false,
    this.isLoading = false,
    this.emphasis = AppButtonEmphasis.strong,
    this.buttonKey,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final double? iconSize;
  final IconAlignment iconAlignment;
  final bool fullWidth;
  final bool fitLabel;
  final bool isLoading;
  final AppButtonEmphasis emphasis;
  final Key? buttonKey;

  double get _height {
    switch (size) {
      case AppButtonSize.micro:
        return AppSizes.buttonCompactHeight;
      case AppButtonSize.toolbar:
        return AppSizes.v40;
      case AppButtonSize.tiny:
      case AppButtonSize.inline:
        return AppSizes.buttonInlineHeight;
      case AppButtonSize.sectionAction:
      case AppButtonSize.gallery:
      case AppButtonSize.compact:
        return AppSizes.buttonCompactHeight;
        return AppSizes.buttonCompactHeight;
      case AppButtonSize.small:
      case AppButtonSize.adminCompact:
        return AppSizes.buttonSmallHeight;
      case AppButtonSize.admin:
      case AppButtonSize.medium:
        return AppSizes.buttonMediumHeight;
      case AppButtonSize.detailCompact:
      case AppButtonSize.detail:
        return AppSizes.v47;
      case AppButtonSize.productDetailAction:
        return AppSizes.v46;
      case AppButtonSize.actionBarCompact:
      case AppButtonSize.actionBar:
        return AppSizes.buttonLargeHeight;
      case AppButtonSize.large:
        return AppSizes.buttonLargeHeight;
      case AppButtonSize.preDashboard:
        return AppSizes.v50;
      case AppButtonSize.prominent:
        return AppSizes.buttonProminentHeight;
      case AppButtonSize.review:
        return AppSizes.buttonReviewHeight;
      case AppButtonSize.extraLarge:
        return AppSizes.buttonExtraLargeHeight;
      case AppButtonSize.profileCompact:
        return AppSizes.buttonProfileCompactHeight;
      case AppButtonSize.authCompact:
        return AppSizes.buttonProminentHeight;
      case AppButtonSize.auth:
      case AppButtonSize.camera:
        return AppSizes.buttonAuthHeight;
      case AppButtonSize.profile:
      case AppButtonSize.jumbo:
        return AppSizes.buttonJumboHeight;
    }
  }

  double get _iconSize {
    switch (size) {
      case AppButtonSize.micro:
      case AppButtonSize.toolbar:
        return AppSizes.iconSm;
      case AppButtonSize.tiny:
        return AppSizes.v17;
      case AppButtonSize.inline:
      case AppButtonSize.sectionAction:
      case AppButtonSize.compact:
      case AppButtonSize.small:
      case AppButtonSize.admin:
      case AppButtonSize.medium:
        return AppSizes.iconMd;
      case AppButtonSize.gallery:
        return AppSizes.iconLg;
      case AppButtonSize.adminCompact:
        return AppSizes.iconSm;
      case AppButtonSize.detailCompact:
      case AppButtonSize.detail:
      case AppButtonSize.authCompact:
        return AppSizes.v22;
      case AppButtonSize.productDetailAction:
        return AppSizes.v20;
      case AppButtonSize.actionBarCompact:
      case AppButtonSize.actionBar:
        return AppSizes.iconAction;
      case AppButtonSize.large:
      case AppButtonSize.preDashboard:
      case AppButtonSize.review:
      case AppButtonSize.extraLarge:
        return AppSizes.iconLg;
      case AppButtonSize.prominent:
      case AppButtonSize.auth:
      case AppButtonSize.camera:
        return AppSizes.v25;
      case AppButtonSize.profileCompact:
      case AppButtonSize.profile:
      case AppButtonSize.jumbo:
        return AppSizes.v26;
    }
  }

  TextStyle get _baseLabelStyle {
    switch (size) {
      case AppButtonSize.micro:
      case AppButtonSize.toolbar:
        return AppTextStyles.microButtonLabel;
      case AppButtonSize.tiny:
        return AppTextStyles.tinyAction;
      case AppButtonSize.inline:
        return AppTextStyles.inlineAction;
      case AppButtonSize.sectionAction:
        return AppTextStyles.sectionAction;
      case AppButtonSize.gallery:
        return AppTextStyles.galleryAction;
      case AppButtonSize.compact:
      case AppButtonSize.small:
        return AppTextStyles.compactAction;
      case AppButtonSize.adminCompact:
        return AppTextStyles.tinyAction;
      case AppButtonSize.admin:
        return AppTextStyles.adminButtonLabel;
      case AppButtonSize.medium:
      case AppButtonSize.large:
        return AppTextStyles.buttonLabel;
      case AppButtonSize.preDashboard:
        return AppTextStyles.preDashboardButtonLabel;
      case AppButtonSize.detailCompact:
      case AppButtonSize.actionBarCompact:
        return AppTextStyles.detailActionCompact;
      case AppButtonSize.productDetailAction:
        return AppTextStyles.productDetailActionLabel;
      case AppButtonSize.detail:
      case AppButtonSize.actionBar:
        return AppTextStyles.detailAction;
      case AppButtonSize.prominent:
        return AppTextStyles.prominentButtonLabel;
      case AppButtonSize.review:
      case AppButtonSize.extraLarge:
      case AppButtonSize.camera:
        return AppTextStyles.buttonLabelLarge;
      case AppButtonSize.profileCompact:
        return AppTextStyles.profileButtonLabelCompact;
      case AppButtonSize.authCompact:
        return AppTextStyles.prominentButtonLabel;
      case AppButtonSize.auth:
        return AppTextStyles.authButtonLabel;
      case AppButtonSize.profile:
        return AppTextStyles.profileButtonLabel;
      case AppButtonSize.jumbo:
        return AppTextStyles.jumboButtonLabel;
    }
  }

  TextStyle get _labelStyle {
    final base = _baseLabelStyle;
    switch (emphasis) {
      case AppButtonEmphasis.standard:
        return base.copyWith(fontWeight: AppTypography.weight600);
      case AppButtonEmphasis.strong:
        return base;
      case AppButtonEmphasis.heavy:
        return base.copyWith(fontWeight: AppTypography.weight900);
    }
  }

  double get _radius {
    switch (variant) {
      case AppButtonVariant.primaryRounded:
      case AppButtonVariant.outlineRounded:
        return AppRadii.xl;
      case AppButtonVariant.primaryDetail:
      case AppButtonVariant.outlineDetail:
        return AppRadii.chip;
      case AppButtonVariant.outlineCompact:
        return AppRadii.sm;
      case AppButtonVariant.primaryElevated:
        return AppRadii.v14;
      case AppButtonVariant.outlineTight:
        return AppRadii.v7;
      case AppButtonVariant.purpleOutline:
        return AppRadii.sm;
      case AppButtonVariant.cameraPrimary:
      case AppButtonVariant.cameraOutline:
        return AppRadii.v20;
      default:
        return size == AppButtonSize.medium || size == AppButtonSize.admin
            ? AppRadii.chip
            : AppRadii.button;
    }
  }

  bool get _isOutlined {
    return variant == AppButtonVariant.outline ||
        variant == AppButtonVariant.outlineStrong ||
        variant == AppButtonVariant.outlineRounded ||
        variant == AppButtonVariant.outlineCompact ||
        variant == AppButtonVariant.outlineDetail ||
        variant == AppButtonVariant.outlineTight ||
        variant == AppButtonVariant.outlineNeutral ||
        variant == AppButtonVariant.duplicateOutline ||
        variant == AppButtonVariant.warningOutline ||
        variant == AppButtonVariant.purpleOutline ||
        variant == AppButtonVariant.cameraOutline;
  }

  bool get _isText {
    return variant == AppButtonVariant.text ||
        variant == AppButtonVariant.textStrong ||
        variant == AppButtonVariant.dangerText ||
        variant == AppButtonVariant.inverseText;
  }

  ButtonStyle _style() {
    Color foreground = AppColors.white;
    Color background = AppColors.primary;
    Color? disabledBackground;
    Color? disabledForeground;
    BorderSide? side;
    double elevation = AppElevation.v0;
    Color? shadowColor;

    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.primaryRounded:
      case AppButtonVariant.primaryDetail:
        disabledBackground = AppColors.disabledSurface;
        disabledForeground = AppColors.disabledForeground;
        break;
      case AppButtonVariant.primaryElevated:
        background = AppColors.elevatedPrimary;
        elevation = AppElevation.v7;
        shadowColor = AppColors.tone55079447;
        break;
      case AppButtonVariant.success:
        background = AppColors.successStrong;
        break;
      case AppButtonVariant.outline:
      case AppButtonVariant.outlineCompact:
      case AppButtonVariant.outlineDetail:
        foreground = AppColors.primary;
        background = AppColors.transparent;
        side = const BorderSide(color: AppColors.primary, width: AppSizes.v1_3);
        break;
      case AppButtonVariant.outlineStrong:
      case AppButtonVariant.outlineRounded:
      case AppButtonVariant.outlineTight:
        foreground = AppColors.primaryDark;
        background = AppColors.transparent;
        side = const BorderSide(color: AppColors.primary, width: AppSizes.v1_2);
        break;
      case AppButtonVariant.outlineNeutral:
        foreground = AppColors.textPrimary;
        background = AppColors.transparent;
        side = const BorderSide(color: AppColors.border);
        break;
      case AppButtonVariant.duplicateOutline:
        foreground = AppColors.textPrimary;
        background = AppColors.transparent;
        side = const BorderSide(
          color: AppColors.neutralOutline,
          width: AppSizes.v1_2,
        );
        break;
      case AppButtonVariant.text:
        foreground = AppColors.primary;
        background = AppColors.transparent;
        break;
      case AppButtonVariant.textStrong:
        foreground = AppColors.primaryDark;
        background = AppColors.transparent;
        break;
      case AppButtonVariant.dangerText:
        foreground = AppColors.error;
        background = AppColors.transparent;
        break;
      case AppButtonVariant.inverseText:
        foreground = AppColors.white;
        background = AppColors.transparent;
        break;
      case AppButtonVariant.warningOutline:
        foreground = AppColors.warningAction;
        background = AppColors.transparent;
        side = const BorderSide(
          color: AppColors.warningOutlineBorder,
          width: AppSizes.v1_2,
        );
        break;
      case AppButtonVariant.purpleOutline:
        foreground = AppColors.purple;
        background = AppColors.transparent;
        side = const BorderSide(color: AppColors.purple);
        break;
      case AppButtonVariant.cameraPrimary:
        background = AppColors.success;
        side = const BorderSide(color: AppColors.success, width: AppSizes.v1_2);
        break;
      case AppButtonVariant.cameraOutline:
        background = AppColors.transparent;
        side = const BorderSide(color: AppColors.white, width: AppSizes.v1_2);
        break;
    }

    final padding = _isText
        ? EdgeInsets.zero
        : size == AppButtonSize.micro || size == AppButtonSize.toolbar
            ? const EdgeInsets.symmetric(horizontal: AppSpacing.cardGap)
            : size == AppButtonSize.productDetailAction
                ? const EdgeInsets.symmetric(horizontal: AppSpacing.md)
                : const EdgeInsets.symmetric(horizontal: AppSpacing.lg);

    return ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled)
          ? disabledForeground ?? foreground
          : foreground,
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled)
          ? disabledBackground ?? background
          : background,
        ),
      side: side == null ? null : WidgetStatePropertyAll(side),
      elevation: WidgetStatePropertyAll(elevation),
      shadowColor: shadowColor == null ? null : WidgetStatePropertyAll(shadowColor),
      minimumSize: WidgetStatePropertyAll(Size(0, _height)),
      padding: WidgetStatePropertyAll(padding),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
      ),
      textStyle: WidgetStatePropertyAll(_labelStyle),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final callback = isLoading ? null : onPressed;
    final child = isLoading
        ? const SizedBox(
            width: AppSizes.v22,
            height: AppSizes.v22,
            child: CircularProgressIndicator(
              strokeWidth: AppSizes.v2_4,
              color: AppColors.white,
            ),
          )
        : _Label(
            label: label,
            icon: icon,
            iconAlignment: iconAlignment,
            iconSize: iconSize ?? _iconSize,
            fitLabel: fitLabel,
            style: _labelStyle,
          );

    late final Widget button;
    if (_isOutlined) {
      button = OutlinedButton(
        key: buttonKey,
        onPressed: callback,
        style: _style(),
        child: child,
      );
    } else if (_isText) {
      button = TextButton(
        key: buttonKey,
        onPressed: callback,
        style: _style(),
        child: child,
      );
    } else if (variant == AppButtonVariant.primaryElevated) {
      button = ElevatedButton(
        key: buttonKey,
        onPressed: callback,
        style: _style(),
        child: child,
      );
    } else {
      button = FilledButton(
        key: buttonKey,
        onPressed: callback,
        style: _style(),
        child: child,
      );
    }

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: _height,
      child: button,
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.label,
    required this.icon,
    required this.iconAlignment,
    required this.iconSize,
    required this.fitLabel,
    required this.style,
  });

  final String label;
  final IconData? icon;
  final IconAlignment iconAlignment;
  final double iconSize;
  final bool fitLabel;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    Widget text = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
    if (fitLabel) {
      text = FittedBox(fit: BoxFit.scaleDown, child: text);
    }
    if (icon == null) return text;

    final iconWidget = Icon(icon, size: iconSize);
    final children = iconAlignment == IconAlignment.end
        ? <Widget>[text, const SizedBox(width: AppSpacing.sm), iconWidget]
        : <Widget>[iconWidget, const SizedBox(width: AppSpacing.sm), text];
    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}

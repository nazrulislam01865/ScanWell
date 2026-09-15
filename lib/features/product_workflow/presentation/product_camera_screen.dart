import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';
import 'package:flutter/services.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';

class ProductCameraScreen extends StatefulWidget {
  const ProductCameraScreen({super.key});

  @override
  State<ProductCameraScreen> createState() => _ProductCameraScreenState();
}

class _ProductCameraScreenState extends State<ProductCameraScreen> {
  bool _flashEnabled = false;
  _CaptureMode _selectedMode = _CaptureMode.barcode;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  void _capture() {
    Navigator.pushReplacementNamed(context, AppRoutes.reviewPhoto);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final shortHeight = size.height < 720;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.reviewPhotoBarcodeWorkflow,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.toneB0000000,
                  AppColors.tone36000000,
                  AppColors.tone22000000,
                  AppColors.tone8A000000,
                ],
                stops: [0.0, 0.26, 0.62, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: ResponsiveContent(
              maxWidth: AppSizes.contentComfortable,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final frameHeight = (constraints.maxHeight * 0.35)
                      .clamp(235.0, 350.0)
                      .toDouble();

                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      shortHeight ? AppSpacing.sm : AppSpacing.v14,
                      AppSpacing.xl,
                      shortHeight ? AppSpacing.lg : AppSpacing.v22,
                    ),
                    child: Column(
                      children: [
                        _TopBar(
                          flashEnabled: _flashEnabled,
                          onBack: () => Navigator.maybePop(context),
                          onFlash: () => setState(
                            () => _flashEnabled = !_flashEnabled,
                          ),
                        ),
                        SizedBox(height: shortHeight ? AppSizes.v18 : AppSizes.v28),
                        Text(
                          'Place the product label\ninside the frame',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.pageTitleFor(
                            compact: shortHeight,
                            variant: AppPageTitleVariant.cameraOnDark,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: shortHeight ? AppSizes.v18 : AppSizes.v27),
                        _CaptureModeSelector(
                          selectedMode: _selectedMode,
                          onSelected: (mode) => setState(
                            () => _selectedMode = mode,
                          ),
                        ),
                        SizedBox(height: shortHeight ? AppSizes.v18 : AppSizes.v30),
                        Expanded(
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth * AppSizes.v0_78,
                                maxHeight: frameHeight,
                              ),
                              child: AspectRatio(
                                aspectRatio: 1.08,
                                child: CustomPaint(
                                  painter: const _CameraFramePainter(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: shortHeight ? AppSizes.v12 : AppSizes.v22),
                        _BottomControls(
                          flashEnabled: _flashEnabled,
                          onGallery: _capture,
                          onCapture: _capture,
                          onFlash: () => setState(
                            () => _flashEnabled = !_flashEnabled,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.flashEnabled,
    required this.onBack,
    required this.onFlash,
  });

  final bool flashEnabled;
  final VoidCallback onBack;
  final VoidCallback onFlash;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          key: const Key('camera-back'),
          onPressed: onBack,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: AppSizes.v48, height: AppSizes.v48),
          icon: const Icon(
            AppIcons.arrow_back_rounded,
            color: AppColors.white,
            size: AppSizes.iconHeroLarge,
          ),
        ),
        const Spacer(),
        Material(
          color: AppColors.toneB22D2D2D,
          borderRadius: BorderRadius.circular(AppRadii.v23),
          child: InkWell(
            onTap: onFlash,
            borderRadius: BorderRadius.circular(AppRadii.v23),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v17, vertical: AppSpacing.md),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    flashEnabled ? AppIcons.flash_on_rounded : AppIcons.flash_off_rounded,
                    color: AppColors.white,
                    size: AppSizes.iconActionLarge,
                  ),
                  const SizedBox(width: AppSizes.v7),
                  Text(
                    flashEnabled ? 'On' : 'Off',
                    style: const AppTextStyle(
                      color: AppColors.white,
                      fontSize: AppTypography.font16,
                      fontWeight: AppTypography.weight600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum _CaptureMode { barcode, frontPack, nutritionLabel, ingredients }

extension on _CaptureMode {
  String get label {
    switch (this) {
      case _CaptureMode.barcode:
        return 'Barcode';
      case _CaptureMode.frontPack:
        return 'Front Pack';
      case _CaptureMode.nutritionLabel:
        return 'Nutrition Label';
      case _CaptureMode.ingredients:
        return 'Ingredients';
    }
  }

  IconData get icon {
    switch (this) {
      case _CaptureMode.barcode:
        return AppIcons.qr_code_2_rounded;
      case _CaptureMode.frontPack:
        return AppIcons.inventory_2_outlined;
      case _CaptureMode.nutritionLabel:
        return AppIcons.receipt_long_outlined;
      case _CaptureMode.ingredients:
        return AppIcons.eco_outlined;
    }
  }
}

class _CaptureModeSelector extends StatelessWidget {
  const _CaptureModeSelector({
    required this.selectedMode,
    required this.onSelected,
  });

  final _CaptureMode selectedMode;
  final ValueChanged<_CaptureMode> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: _CaptureMode.values
            .map(
              (mode) => Padding(
                padding: EdgeInsets.only(
                  right: mode == _CaptureMode.values.last ? AppSpacing.none : AppSpacing.sm,
                ),
                child: _CaptureModeChip(
                  mode: mode,
                  selected: mode == selectedMode,
                  onTap: () => onSelected(mode),
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _CaptureModeChip extends StatelessWidget {
  const _CaptureModeChip({
    required this.mode,
    required this.selected,
    required this.onTap,
  });

  final _CaptureMode mode;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final green = AppColors.toneFF58C83E;

    return Material(
      color: selected ? green : AppColors.toneB12A2928,
      borderRadius: BorderRadius.circular(AppRadii.v24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.v24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.v14, vertical: AppSpacing.v10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.v24),
            border: Border.all(
              color: selected ? green : AppColors.white30,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(mode.icon, color: AppColors.white, size: AppSizes.iconMediumTight),
              const SizedBox(width: AppSizes.v7),
              Text(
                mode.label,
                style: const AppTextStyle(
                  color: AppColors.white,
                  fontSize: AppTypography.font12_5,
                  fontWeight: AppTypography.weight500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CameraFramePainter extends CustomPainter {
  const _CameraFramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final glow = Paint()
      ..color = AppColors.tone805CFF4E
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    final paint = Paint()
      ..color = AppColors.toneFF66FF52
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const radius = 28.0;
    final corner = (size.shortestSide * 0.22).clamp(42.0, 68.0).toDouble();
    final rect = Rect.fromLTWH(2, 2, size.width - 4, size.height - 4);

    void drawCorners(Paint p) {
      final paths = <Path>[
        Path()
          ..moveTo(rect.left, rect.top + radius + corner)
          ..lineTo(rect.left, rect.top + radius)
          ..quadraticBezierTo(rect.left, rect.top, rect.left + radius, rect.top)
          ..lineTo(rect.left + radius + corner, rect.top),
        Path()
          ..moveTo(rect.right - radius - corner, rect.top)
          ..lineTo(rect.right - radius, rect.top)
          ..quadraticBezierTo(rect.right, rect.top, rect.right, rect.top + radius)
          ..lineTo(rect.right, rect.top + radius + corner),
        Path()
          ..moveTo(rect.left, rect.bottom - radius - corner)
          ..lineTo(rect.left, rect.bottom - radius)
          ..quadraticBezierTo(rect.left, rect.bottom, rect.left + radius, rect.bottom)
          ..lineTo(rect.left + radius + corner, rect.bottom),
        Path()
          ..moveTo(rect.right - radius - corner, rect.bottom)
          ..lineTo(rect.right - radius, rect.bottom)
          ..quadraticBezierTo(rect.right, rect.bottom, rect.right, rect.bottom - radius)
          ..lineTo(rect.right, rect.bottom - radius - corner),
      ];
      for (final path in paths) {
        canvas.drawPath(path, p);
      }
    }

    drawCorners(glow);
    drawCorners(paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BottomControls extends StatelessWidget {
  const _BottomControls({
    required this.flashEnabled,
    required this.onGallery,
    required this.onCapture,
    required this.onFlash,
  });

  final bool flashEnabled;
  final VoidCallback onGallery;
  final VoidCallback onCapture;
  final VoidCallback onFlash;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _RoundCameraAction(
          label: 'Upload from\nGallery',
          icon: AppIcons.photo_library_outlined,
          onTap: onGallery,
        ),
        GestureDetector(
          key: const Key('camera-shutter'),
          onTap: onCapture,
          child: Container(
            width: compact ? AppSizes.v91 : AppSizes.v104,
            height: compact ? AppSizes.v91 : AppSizes.v104,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.toneFF73DB51, width: AppSizes.v5),
            ),
            padding: const EdgeInsets.all(AppSpacing.v7),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        _RoundCameraAction(
          label: 'Flash',
          icon: flashEnabled ? AppIcons.flash_on_rounded : AppIcons.flash_on_rounded,
          onTap: onFlash,
        ),
      ],
    );
  }
}

class _RoundCameraAction extends StatelessWidget {
  const _RoundCameraAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return SizedBox(
      width: compact ? AppSizes.v88 : AppSizes.v103,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: AppColors.toneB02A2A2A,
            shape: CircleBorder(side: BorderSide(color: AppColors.white.withOpacity(AppOpacity.v0_24))),
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: SizedBox(
                width: compact ? AppSizes.v66 : AppSizes.v74,
                height: compact ? AppSizes.v66 : AppSizes.v74,
                child: Icon(icon, color: AppColors.white, size: compact ? AppSizes.v31 : AppSizes.v36),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.v8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const AppTextStyle(
              color: AppColors.white,
              fontSize: AppTypography.font13_5,
              height: AppTypography.lineHeight1_13,
              fontWeight: AppTypography.weight500,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../tokens/app_colors.dart';

/// Typography primitives. ScanWell intentionally keeps Flutter's platform-default
/// font family so this migration does not alter text metrics or visual rendering.

/// Central TextStyle entry point. It preserves Flutter TextStyle semantics while
/// ensuring feature code cannot bypass the design-system typography primitives.
class AppTextStyle extends TextStyle {
  const AppTextStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    double? decorationThickness,
    List<Shadow>? shadows,
  }) : super(
          color: color,
          fontFamily: AppTypography.fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
          decoration: decoration,
          decorationThickness: decorationThickness,
          shadows: shadows,
        );
}

abstract final class AppTypography {
  AppTypography._();

  static const String? fontFamily = null;

  static const double font8 = 8;
  static const double font8_5 = 8.5;
  static const double font9 = 9;
  static const double font9_2 = 9.2;
  static const double font9_3 = 9.3;
  static const double font9_5 = 9.5;
  static const double font9_6 = 9.6;
  static const double font10 = 10;
  static const double font10_2 = 10.2;
  static const double font10_3 = 10.3;
  static const double font10_4 = 10.4;
  static const double font10_5 = 10.5;
  static const double font10_6 = 10.6;
  static const double font10_8 = 10.8;
  static const double font11 = 11;
  static const double font11_2 = 11.2;
  static const double font11_5 = 11.5;
  static const double font11_6 = 11.6;
  static const double font11_8 = 11.8;
  static const double font12 = 12;
  static const double font12_2 = 12.2;
  static const double font12_5 = 12.5;
  static const double font12_6 = 12.6;
  static const double font12_7 = 12.7;
  static const double font12_8 = 12.8;
  static const double font13 = 13;
  static const double font13_2 = 13.2;
  static const double font13_4 = 13.4;
  static const double font13_5 = 13.5;
  static const double font13_8 = 13.8;
  static const double font14 = 14;
  static const double font14_5 = 14.5;
  static const double font14_8 = 14.8;
  static const double font15 = 15;
  static const double font15_3 = 15.3;
  static const double font15_5 = 15.5;
  static const double font16 = 16;
  static const double font16_5 = 16.5;
  static const double font17 = 17;
  static const double font18 = 18;
  static const double font19 = 19;
  static const double font19_5 = 19.5;
  static const double font20 = 20;
  static const double font21 = 21;
  static const double font22 = 22;
  static const double font23 = 23;
  static const double font24 = 24;
  static const double font25 = 25;
  static const double font26 = 26;
  static const double font27 = 27;
  static const double font28 = 28;
  static const double font29 = 29;
  static const double font30 = 30;
  static const double font31 = 31;
  static const double font32 = 32;
  static const double font34 = 34;
  static const double font35 = 35;
  static const double font36 = 36;
  static const double font40 = 40;

  static const FontWeight weight400 = FontWeight.w400;
  static const FontWeight weight500 = FontWeight.w500;
  static const FontWeight weight600 = FontWeight.w600;
  static const FontWeight weight700 = FontWeight.w700;
  static const FontWeight weight800 = FontWeight.w800;
  static const FontWeight weight900 = FontWeight.w900;

  static const double lineHeight0_95 = 0.95;
  static const double lineHeight1 = 1;
  static const double lineHeight1_02 = 1.02;
  static const double lineHeight1_03 = 1.03;
  static const double lineHeight1_05 = 1.05;
  static const double lineHeight1_06 = 1.06;
  static const double lineHeight1_08 = 1.08;
  static const double lineHeight1_1 = 1.1;
  static const double lineHeight1_12 = 1.12;
  static const double lineHeight1_13 = 1.13;
  static const double lineHeight1_14 = 1.14;
  static const double lineHeight1_15 = 1.15;
  static const double lineHeight1_16 = 1.16;
  static const double lineHeight1_18 = 1.18;
  static const double lineHeight1_2 = 1.2;
  static const double lineHeight1_24 = 1.24;
  static const double lineHeight1_25 = 1.25;
  static const double lineHeight1_28 = 1.28;
  static const double lineHeight1_3 = 1.3;
  static const double lineHeight1_35 = 1.35;
  static const double lineHeight1_36 = 1.36;
  static const double lineHeight1_4 = 1.4;
  static const double lineHeight1_45 = 1.45;
  static const double lineHeight1_46 = 1.46;
  static const double lineHeight1_5 = 1.5;
  static const double lineHeight1_55 = 1.55;

  static const double letterSpacingn1 = -1;
  static const double letterSpacingn0_8 = -0.8;
  static const double letterSpacingn0_7 = -0.7;
  static const double letterSpacingn0_6 = -0.6;
  static const double letterSpacingn0_55 = -0.55;
  static const double letterSpacingn0_5 = -0.5;
  static const double letterSpacingn0_45 = -0.45;
  static const double letterSpacingn0_4 = -0.4;
  static const double letterSpacingn0_35 = -0.35;
  static const double letterSpacingn0_3 = -0.3;
  static const double letterSpacingn0_25 = -0.25;
  static const double letterSpacingn0_2 = -0.2;
  static const double letterSpacing0 = 0;

  static const double decorationThickness1_6 = 1.6;

  static TextTheme applyTo(TextTheme base) => base.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      );
}

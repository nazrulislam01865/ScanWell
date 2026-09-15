import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_nutrient_app/core/design_system/design_system.dart';
import 'package:food_nutrient_app/features/consumer/presentation/product_detail_screen.dart';
import 'package:food_nutrient_app/features/settings/presentation/settings_screen.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: child,
    );
  }

  test('product detail and profile typography stays compact', () {
    expect(AppTextStyles.productDetailTitleFor(compact: true).fontSize, 17);
    expect(AppTextStyles.productDetailTitleFor(compact: false).fontSize, 18);
    expect(AppTextStyles.productDetailTitleFor(compact: false).fontWeight, AppTypography.weight600);
    expect(AppTextStyles.productDetailBrand.fontSize, 12.5);
    expect(AppTextStyles.productDetailMeta.fontSize, 11);
    expect(AppTextStyles.productDetailMeta.fontWeight, AppTypography.weight400);
    expect(AppTextStyles.productDetailSectionTitle.fontSize, 16);
    expect(AppTextStyles.productDetailSectionTitle.fontWeight, AppTypography.weight700);
    expect(AppTextStyles.productDetailBody.fontSize, 13);
    expect(AppTextStyles.productDetailMetricValue.fontSize, 17);
    expect(AppTextStyles.productDetailHealthStatusFor(compact: true).fontSize, 16);
    expect(AppTextStyles.productDetailHealthStatusFor(compact: false).fontSize, 16);
    expect(AppTextStyles.productDetailHealthStatusFor(compact: false).fontWeight, AppTypography.weight600);
    expect(AppTextStyles.productDetailScoreFor(compact: true).fontSize, 24);
    expect(AppTextStyles.productDetailScoreFor(compact: false).fontSize, 26);
    expect(AppTextStyles.productDetailScoreFor(compact: false).fontWeight, AppTypography.weight700);
    expect(AppTextStyles.productDetailActionLabel.fontSize, 13.5);
    expect(AppTextStyles.productDetailActionLabel.fontWeight, AppTypography.weight600);

    expect(AppTextStyles.profilePageTitleFor(compact: true).fontSize, 22);
    expect(AppTextStyles.profilePageTitleFor(compact: false).fontSize, 24);
    expect(AppTextStyles.profileMenuLabelFor(compact: true).fontSize, 14);
    expect(AppTextStyles.profileMenuLabelFor(compact: false).fontSize, 15);
  });

  testWidgets('profile page uses compact semantic hierarchy', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(wrap(const SettingsScreen()));
    await tester.pump();

    final title = tester.widget<Text>(find.text('Settings'));
    expect(title.style?.fontSize, lessThanOrEqualTo(24));
    expect(title.style?.fontWeight, AppTypography.weight700);

    final account = tester.widget<Text>(find.text('Account'));
    expect(account.style?.fontSize, lessThanOrEqualTo(15));
  });

  testWidgets('product detail keeps product title and score readable but compact', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(wrap(const ProductDetailScreen()));
    await tester.pump();

    final score = tester.widget<Text>(find.text('58'));
    expect(score.style?.fontSize, lessThanOrEqualTo(26));
    expect(score.style?.fontWeight, AppTypography.weight700);

    final title = tester.widget<Text>(find.text('Lay’s American Style Cream & Onion'));
    expect(title.style?.fontSize, lessThanOrEqualTo(18));
    expect(title.style?.fontWeight, AppTypography.weight600);

    final save = tester.widget<Text>(find.text('Save Product'));
    final correction = tester.widget<Text>(find.text('Suggest Correction'));
    expect(save.style?.fontSize, 13.5);
    expect(save.style?.fontWeight, AppTypography.weight600);
    expect(correction.style?.fontSize, 13.5);
    expect(correction.style?.fontWeight, AppTypography.weight600);
  });

  testWidgets('product detail adapts health score and actions on narrow phones', (tester) async {
    tester.view.physicalSize = const Size(320, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(wrap(const ProductDetailScreen()));
    await tester.pump();

    final statusRect = tester.getRect(find.text('Use with Caution'));
    final scoreRect = tester.getRect(find.text('58'));
    expect(scoreRect.top, greaterThan(statusRect.bottom));

    final saveRect = tester.getRect(find.byKey(const Key('save-product-action')));
    final correctionRect = tester.getRect(find.byKey(const Key('suggest-correction-action')));
    expect(correctionRect.top, greaterThan(saveRect.bottom));
    expect(tester.takeException(), isNull);
  });

  testWidgets('product detail keeps normal-phone actions inline with room for correction', (tester) async {
    tester.view.physicalSize = const Size(390, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(wrap(const ProductDetailScreen()));
    await tester.pump();

    final saveRect = tester.getRect(find.byKey(const Key('save-product-action')));
    final correctionRect = tester.getRect(find.byKey(const Key('suggest-correction-action')));
    expect((saveRect.center.dy - correctionRect.center.dy).abs(), lessThan(2));
    expect(correctionRect.width, greaterThan(saveRect.width));
    expect(tester.takeException(), isNull);
  });

}

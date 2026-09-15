import 'package:flutter_test/flutter_test.dart';
import 'package:food_nutrient_app/app/app.dart';

void main() {
  testWidgets('shows the first onboarding screen', (tester) async {
    await tester.pumpWidget(const ScanWellApp());
    await tester.pumpAndSettle();

    expect(find.text('1 of 3'), findsOneWidget);
    expect(find.text('Scan packaged products'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}

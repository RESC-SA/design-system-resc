import 'package:flutter_test/flutter_test.dart';
import 'package:design_system_example/main.dart';
import 'package:design_system_example/pages/home_page.dart';

void main() {
  testWidgets('DesignSystemShowcase builds HomePage smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DesignSystemShowcase());
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });
}

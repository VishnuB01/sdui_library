import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('SDUI Demo app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SduiExampleApp());
    await tester.pumpAndSettle();

    // The app bar title should be visible
    expect(find.text('SDUI Library Demo'), findsOneWidget);
  });
}

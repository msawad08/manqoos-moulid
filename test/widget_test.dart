import 'package:flutter_test/flutter_test.dart';

import 'package:manqoos_mawlid/main.dart';

void main() {
  testWidgets('home shows the Manqoos Mawlid menu', (tester) async {
    await tester.pumpWidget(const ManqoosApp());

    expect(find.text('ISLAMIC WAY'), findsOneWidget);
    expect(find.text('MAWLID'), findsOneWidget);
    expect(find.text('TRANSLATION'), findsOneWidget);
  });

  testWidgets('Mawlid menu opens chapters', (tester) async {
    await tester.pumpWidget(const ManqoosApp());
    await tester.tap(find.text('MAWLID'));
    await tester.pumpAndSettle();

    expect(find.text('Chapters'), findsOneWidget);
    expect(find.text('01  Hadees & Baith'), findsOneWidget);
  });
}

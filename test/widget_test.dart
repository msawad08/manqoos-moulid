import 'package:flutter_test/flutter_test.dart';

import 'package:manqoos_mawlid/main.dart';

void main() {
  testWidgets('home shows the Manqoos Mawlid menu', (tester) async {
    await tester.pumpWidget(const ManqoosApp());

    expect(find.text('ISLAMIC WAY'), findsOneWidget);
    expect(find.text('MAWLID'), findsNWidgets(2));
  });

  testWidgets('Mawlid menu opens chapters and loads a valid chapter', (
    tester,
  ) async {
    await tester.pumpWidget(const ManqoosApp());
    await tester.tap(find.text('MAWLID').first);
    await tester.pumpAndSettle();

    expect(find.text('Chapters'), findsOneWidget);
    expect(find.textContaining('Chapter 1'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
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

  testWidgets('chapter reader keeps later chapters in the same scroll flow', (
    tester,
  ) async {
    await tester.pumpWidget(const ManqoosApp());
    await tester.tap(find.text('MAWLID').first);
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Chapter 3'));
    await tester.pumpAndSettle();

    expect(find.textContaining('CHAPTER 03'), findsOneWidget);
    expect(orderedChapterNumbers(3), [3, 4, 5, 6, 1, 2]);
  });

  testWidgets('reciter screen displays reciter cards and handles selection', (
    tester,
  ) async {
    await tester.pumpWidget(const ManqoosApp());
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(find.text('RECITER'));
    await tester.pumpAndSettle();

    expect(find.text('Reciters'), findsOneWidget);
    expect(
      find.textContaining('Sayyid Thaha Tangal Pookkottur'),
      findsOneWidget,
    );
    expect(find.textContaining("Arif Sa'adi Katipalla"), findsOneWidget);
    expect(find.text('Selected'), findsOneWidget);

    // Tap Arif Sa'adi to select
    await tester.tap(find.textContaining("Arif Sa'adi Katipalla"));
    await tester.pumpAndSettle();

    expect(appSettings.value.reciter, "Arif Sa'adi Katipalla");
    expect(find.text('Selected'), findsOneWidget);
  });

  test('reciter service maps correct audio assets to reciters', () {
    final thaha = findReciter('Sayyid Thaha Tangal Pookkottur / Hafiz Nizamuddeen Mahmoodi');
    expect(thaha.audioAsset, 'audio/taha_manqus-c.mp3');
    expect(thaha.imagePath, 'assets/images/thaha_tangal.png');

    final arif = findReciter("Arif Sa'adi Katipalla");
    expect(arif.audioAsset, 'audio/arif-c.mp3');
    expect(arif.imagePath, 'assets/images/arif_sadi.png');
  });

  testWidgets('reader screen shows audio controls with selected reciter', (
    tester,
  ) async {
    appSettings.value = const AppSettings(
      translationEnabled: true,
      reciter: "Arif Sa'adi Katipalla",
    );
    await tester.pumpWidget(const ManqoosApp());
    await tester.tap(find.text('MAWLID').first);
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Chapter 1'));
    await tester.pumpAndSettle();

    expect(find.text("Arif Sa'adi Katipalla"), findsOneWidget);
    expect(find.byIcon(Icons.play_circle_fill), findsOneWidget);
    expect(find.byIcon(Icons.stop_circle), findsOneWidget);
  });

  testWidgets('arabic pdf screen shows audio bar with selected reciter', (
    tester,
  ) async {
    appSettings.value = const AppSettings(
      translationEnabled: false,
      reciter: 'Sayyid Thaha Tangal Pookkottur / Hafiz Nizamuddeen Mahmoodi',
    );
    await tester.pumpWidget(const ManqoosApp());
    await tester.tap(find.text('MAWLID').first);
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Chapter 1'));
    await tester.pumpAndSettle();

    expect(
      find.text('Sayyid Thaha Tangal Pookkottur / Hafiz Nizamuddeen Mahmoodi'),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.play_circle_fill), findsOneWidget);
    expect(find.byIcon(Icons.stop_circle), findsOneWidget);
  });

  testWidgets('bottom bar navigation to Settings allows back button to return to Home', (
    tester,
  ) async {
    appSettings.value = const AppSettings();
    await tester.pumpWidget(const ManqoosApp());

    // Tap SETTINGS in bottom navigation bar
    await tester.tap(find.text('SETTINGS').last);
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Translation language'), findsOneWidget);

    // Tap the top-left back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify returned to Home
    expect(find.text('ISLAMIC WAY'), findsOneWidget);
    expect(find.text('MAWLID'), findsWidgets);
  });

  testWidgets('bottom bar navigation to Mawlid allows back button to return to Home', (
    tester,
  ) async {
    appSettings.value = const AppSettings();
    await tester.pumpWidget(const ManqoosApp());

    // Tap MAWLID in bottom navigation bar
    await tester.tap(find.text('MAWLID').last);
    await tester.pumpAndSettle();

    expect(find.text('Mawlid'), findsOneWidget);
    expect(find.text('Translation'), findsOneWidget);

    // Tap the top-left back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify returned to Home
    expect(find.text('ISLAMIC WAY'), findsOneWidget);
  });

  test('bilingual about data provides content in English and Kannada', () {
    final mawlidEn = AboutData.get('About Mawlid', 'English');
    expect(mawlidEn.title, contains('About Manqoos Mawlid'));
    expect(mawlidEn.sections.isNotEmpty, isTrue);

    final mawlidKn = AboutData.get('About Mawlid', 'Kannada');
    expect(mawlidKn.title, contains('ಮಂಕೂಸ್ ಮೌಲಿದ್'));
    expect(mawlidKn.sections.isNotEmpty, isTrue);

    final appEn = AboutData.get('About App', 'English');
    expect(appEn.sections.first.body, contains('Noufal Marzuqi Malar'));
    expect(appEn.sections.first.body, contains('Shafeeq Hudawi'));

    final appKn = AboutData.get('About App', 'Kannada');
    expect(appKn.title, contains('ಆ್ಯಪ್'));
    expect(appKn.sections.first.body, contains('ನೌಫಲ್ ಮರ್ಝೂಖಿ ಮಲಾರ್'));
    expect(appKn.sections.first.body, contains('ಶಫೀಖ್ ಹುದವಿ'));

    final qaKn = AboutData.get('Q&A', 'Kannada');
    expect(qaKn.title, contains('ಪ್ರಶ್ನೋತ್ತರಗಳು'));

    final usEn = AboutData.get('About Us', 'English');
    expect(usEn.title, contains('Islamic Way'));
    expect(usEn.summary, contains('ensemble of some like minded youths'));

    final usKn = AboutData.get('About Us', 'Kannada');
    expect(usKn.title, contains('ಇಸ್ಲಾಮಿಕ್ ವೇ'));
    expect(usKn.summary, contains('ಸಮಾನ ಮನಸ್ಕ ಯುವಕರ'));
  });

  test('font size levels provide distinct scaling sizes', () {
    expect(FontSizeLevel.small.translationFontSize, lessThan(FontSizeLevel.medium.translationFontSize));
    expect(FontSizeLevel.medium.translationFontSize, lessThan(FontSizeLevel.large.translationFontSize));

    expect(FontSizeLevel.small.explanationFontSize, lessThan(FontSizeLevel.medium.explanationFontSize));
    expect(FontSizeLevel.medium.explanationFontSize, lessThan(FontSizeLevel.large.explanationFontSize));

    expect(FontSizeLevel.small.aboutFontSize, lessThan(FontSizeLevel.medium.aboutFontSize));
    expect(FontSizeLevel.medium.aboutFontSize, lessThan(FontSizeLevel.large.aboutFontSize));
  });
}


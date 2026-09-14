import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:manqoos_mawlid/audio_player_service.dart';
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
}


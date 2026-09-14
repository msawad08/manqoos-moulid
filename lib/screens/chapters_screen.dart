import 'package:flutter/material.dart';
import '../content.dart';
import '../models/app_settings.dart';
import '../widgets/branded_app_bar.dart';
import '../widgets/pattern_body.dart';
import 'arabic_pdf_screen.dart';
import 'reader_screen.dart';

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BrandedAppBar(title: 'Chapters', subtitle: 'ಅಧ್ಯಾಯಗಳು'),
      body: FutureBuilder<MawlidContent>(
        future: MawlidContent.loadEnglish(),
        builder: (context, snapshot) {
          final content = snapshot.data ?? MawlidContent.fallbackEnglish();
          final chapters = content.chapters;
          return PatternBody(
            child: ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapter = chapters[index];
                final label = chapter.number == 6 ? 'Dua' : 'Hadees & Baith';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: OutlinedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) {
                          currentChapter.value = chapter.number;
                          return ValueListenableBuilder<AppSettings>(
                            valueListenable: appSettings,
                            builder: (context, settings, _) =>
                                settings.translationEnabled
                                ? ReaderScreen(chapterNumber: chapter.number)
                                : ArabicPdfScreen(
                                    chapterNumber: chapter.number,
                                  ),
                          );
                        },
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      minimumSize: const Size.fromHeight(58),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Chapter ${chapter.number}  $label',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

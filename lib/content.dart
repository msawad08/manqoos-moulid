import 'dart:convert';

import 'package:flutter/services.dart';

class MawlidEntry {
  const MawlidEntry({
    required this.arabic,
    required this.english,
    this.kannada = '',
    this.explanation = '',
  });

  final String arabic;
  final String english;
  final String kannada;
  final String explanation;

  factory MawlidEntry.fromJson(Map<String, dynamic> json) => MawlidEntry(
    arabic: json['arabic'] as String? ?? '',
    english: json['english'] as String? ?? '',
    kannada: json['kannada'] as String? ?? '',
    explanation: json['explanation'] as String? ?? '',
  );
}

class MawlidChapter {
  const MawlidChapter({
    required this.number,
    required this.source,
    required this.entries,
  });

  final int number;
  final String source;
  final List<MawlidEntry> entries;

  factory MawlidChapter.fromJson(Map<String, dynamic> json) => MawlidChapter(
    number: json['chapter'] as int,
    source: json['source'] as String,
    entries: (json['entries'] as List<dynamic>)
        .map((entry) => MawlidEntry.fromJson(entry as Map<String, dynamic>))
        .toList(growable: false),
  );
}

class MawlidContent {
  const MawlidContent({required this.language, required this.chapters});

  final String language;
  final List<MawlidChapter> chapters;

  factory MawlidContent.fromJson(Map<String, dynamic> json) => MawlidContent(
    language: json['language'] as String,
    chapters: (json['chapters'] as List<dynamic>)
        .map(
          (chapter) => MawlidChapter.fromJson(chapter as Map<String, dynamic>),
        )
        .toList(growable: false),
  );

  static MawlidContent fallbackEnglish() => MawlidContent(
    language: 'English',
    chapters: List.generate(
      6,
      (index) => MawlidChapter(
        number: index + 1,
        source: 'fallback',
        entries: const [
          MawlidEntry(
            arabic: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
            english:
                'In the name of Allah, the Most Gracious, the Most Merciful.',
          ),
          MawlidEntry(
            arabic: 'اَلْحَمْدُ لِلَّهِ',
            english: 'All praise is due to Allah.',
          ),
        ],
      ),
    ),
  );

  static Future<MawlidContent> loadEnglish() async {
    return load('English', 'assets/content/chapters.json');
  }

  static Future<MawlidContent> loadKannada() async {
    return load('Kannada', 'assets/content/kannada_chapters.json');
  }

  static Future<MawlidContent> load(String language, String asset) async {
    try {
      final source = await rootBundle.loadString(asset);
      return MawlidContent.fromJson(jsonDecode(source) as Map<String, dynamic>);
    } catch (_) {
      return fallbackEnglish();
    }
  }
}

String pdfAssetForChapter(int chapterNumber) =>
    chapterNumber == 6
        ? 'assets/pdf/chapter 6 dua.pdf'
        : 'assets/pdf/Chapter $chapterNumber.pdf';

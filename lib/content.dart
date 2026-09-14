import 'dart:convert';

import 'package:flutter/services.dart';

class MawlidEntry {
  const MawlidEntry({required this.arabic, required this.english});

  final String arabic;
  final String english;

  factory MawlidEntry.fromJson(Map<String, dynamic> json) => MawlidEntry(
        arabic: json['arabic'] as String? ?? '',
        english: json['english'] as String? ?? '',
      );
}

class MawlidChapter {
  const MawlidChapter({required this.number, required this.source, required this.entries});

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
            .map((chapter) => MawlidChapter.fromJson(chapter as Map<String, dynamic>))
            .toList(growable: false),
      );

  static Future<MawlidContent> loadEnglish() async {
    final source = await rootBundle.loadString('assets/content/chapters.json');
    return MawlidContent.fromJson(jsonDecode(source) as Map<String, dynamic>);
  }
}

import 'package:flutter/foundation.dart';

enum FontSizeLevel { small, medium, large }

extension FontSizeLevelExt on FontSizeLevel {
  String get label => switch (this) {
    FontSizeLevel.small => 'Small',
    FontSizeLevel.medium => 'Medium',
    FontSizeLevel.large => 'Large',
  };

  String get kannadaLabel => switch (this) {
    FontSizeLevel.small => 'ಸಣ್ಣ',
    FontSizeLevel.medium => 'ಮಧ್ಯಮ',
    FontSizeLevel.large => 'ದೊಡ್ಡ',
  };

  double get translationFontSize => switch (this) {
    FontSizeLevel.small => 15.0,
    FontSizeLevel.medium => 18.0,
    FontSizeLevel.large => 22.0,
  };

  double get explanationFontSize => switch (this) {
    FontSizeLevel.small => 14.0,
    FontSizeLevel.medium => 16.0,
    FontSizeLevel.large => 19.0,
  };

  double get aboutFontSize => switch (this) {
    FontSizeLevel.small => 15.0,
    FontSizeLevel.medium => 17.5,
    FontSizeLevel.large => 21.0,
  };
}

class AppSettings {
  const AppSettings({
    this.translationEnabled = true,
    this.mushafArabic = true,
    this.language = 'Kannada',
    this.reciter =
        'Sayyid Thaha Tangal Pookkottur / Hafiz Nizamuddeen Mahmoodi',
    this.fontSize = FontSizeLevel.medium,
  });

  final bool translationEnabled;
  final bool mushafArabic;
  final String language;
  final String reciter;
  final FontSizeLevel fontSize;

  AppSettings copyWith({
    bool? translationEnabled,
    bool? mushafArabic,
    String? language,
    String? reciter,
    FontSizeLevel? fontSize,
  }) => AppSettings(
    translationEnabled: translationEnabled ?? this.translationEnabled,
    mushafArabic: mushafArabic ?? this.mushafArabic,
    language: language ?? this.language,
    reciter: reciter ?? this.reciter,
    fontSize: fontSize ?? this.fontSize,
  );
}

final appSettings = ValueNotifier(const AppSettings());
final currentChapter = ValueNotifier(1);

# Manqoos Mawlid

A Flutter mobile app rebuilt from reference materials for the Manqoos Mawlid experience, targeting Android and iOS. The project includes a green Islamic-themed interface, chapter navigation, English translation reading, settings, reciter selection, and app information screens.

## Overview

This app is a reverse-engineered rebuild created from the available source references, screenshots, PSD designs, PDFs, and workbook materials in the project folder. The goal is to recreate the original app experience in a clean, maintainable Flutter structure while keeping the content local and offline.

## Features

- Home dashboard with Islamic-themed cards
- Chapter-based Mawlid navigation
- Translation reader with English content and bundled Kannada/Arabic font support
- Translation-disabled Arabic PDF reader with scrollable chapter documents
- Separate Amiri traditional Arabic and Noto Naskh Arabic Mushaf font options
- Reciter selection flow
- Settings screen with language selection
- About pages for Mawlid, app information, and general app details
- Offline content loading from bundled asset data
- Android and iOS target support

## Project structure

- lib/main.dart: application UI and navigation
- lib/content.dart: content model and JSON loading
- assets/content/chapters.json: generated chapter data
- assets/content/kannada_chapters.json: generated UTF-8 Kannada chapter data
- assets/fonts/: bundled Noto Sans Kannada, Noto Naskh Arabic, and Amiri fonts
- assets/pdf/: compressed chapter PDF assets used by the Arabic reader
- tool/convert_xlsx_sources.py: workbook-to-JSON conversion utility
- tool/normalize_kannada_sources.py: strict mapping-driven Nudi-to-Unicode normalization pipeline
- android/: Android configuration
- ios/: iOS configuration
- test/: widget tests

## Getting started

### Prerequisites

- Flutter SDK installed and configured on your system
- Android Studio or Xcode for device/emulator builds
- A working terminal with Flutter available in PATH

### Install and run

```bash
flutter pub get
flutter run
```

### Run tests

```bash
flutter test
```

## Content and source notes

This project includes generated content derived from the workbook and PDF sources supplied in the repository. The English and Kannada chapter content are bundled as UTF-8 JSON for offline use in the app. The Kannada workbooks use Nudi legacy glyph encoding. The checked-in Kannada JSON was generated and verified with the upstream [ascii2unicode](https://github.com/aravindavk/ascii2unicode) Nudi converter, then reviewed for Kannada Unicode output. The converter is GPL-licensed and is used as an external content-generation tool; see `THIRD_PARTY_NOTICES.md`. The local normalization script deliberately refuses to publish partially converted text without an explicit mapping.

## Current status

This rebuild is intended as a faithful prototype and content-backed implementation based on the supplied references rather than a straight source-code recovery of the original app.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

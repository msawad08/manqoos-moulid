# Manqoos Mawlid

A Flutter mobile app rebuilt from reference materials for the Manqoos Mawlid experience, targeting Android and iOS. The project includes a green Islamic-themed interface, chapter navigation, English translation reading, settings, reciter selection, and app information screens.

## Overview

This app is a reverse-engineered rebuild created from the available source references, screenshots, PSD designs, PDFs, and workbook materials in the project folder. The goal is to recreate the original app experience in a clean, maintainable Flutter structure while keeping the content local and offline.

## Features

- Home dashboard with Islamic-themed cards
- Chapter-based Mawlid navigation
- English translation reader
- Reciter selection flow
- Settings screen with language selection
- About pages for Mawlid, app information, and general app details
- Offline content loading from bundled asset data
- Android and iOS target support

## Project structure

- lib/main.dart: application UI and navigation
- lib/content.dart: content model and JSON loading
- assets/content/chapters.json: generated chapter data
- tool/convert_xlsx_sources.py: workbook-to-JSON conversion utility
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

This project includes generated content derived from the workbook and PDF sources supplied in the repository. The English chapter content has been converted into UTF-8 JSON for offline use in the app. Kannada content remains a known follow-up item due to legacy encoding in the original workbook source.

## Current status

This rebuild is intended as a faithful prototype and content-backed implementation based on the supplied references rather than a straight source-code recovery of the original app.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

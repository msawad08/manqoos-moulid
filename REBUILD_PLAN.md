# Manqoos Mawlid Rebuild Plan

## Goal

Rebuild the Manqoos Mawlid experience in Flutter for both iOS and Android from the provided App Store reference, screenshots, PSD designs, reciter assets, and Mawlid PDFs. The first milestone is a faithful mobile prototype with working navigation and reading interactions, followed by real offline content and audio.

## Phase 1: Reference Audit

- [x] Review App Store description and visible feature set.
- [x] Inventory supplied PSD, image, PDF, ZIP, and archive files.
- [x] Review supplied screenshots for home, chapters, reader, reciter, settings, and about flows.
- [x] Identify the final source text and chapter boundaries from the supplied PDFs.
- [x] Locate chapter-wise Kannada and English translation workbooks.
- [x] Verify that Kannada workbook cells use legacy encoding rather than Unicode Kannada.
- [ ] Normalize and visually verify legacy-encoded Kannada cells before publishing them in Flutter.
- [ ] Extract or export any reusable PSD artwork that improves fidelity.

**Exit criteria:** The product surface, content sources, and visual assets are mapped well enough to implement without guessing at primary screens.

## Phase 2: Flutter Mobile Foundation

- [x] Create the Flutter project with iOS and Android targets.
- [x] Define the app theme, typography, colors, and reusable ornamental widgets.
- [x] Bundle supplied image assets through Flutter asset configuration.
- [x] Set up a route/state structure for home, chapters, reader, reciter, settings, and about screens.
- [x] Add Android and iOS display-name metadata.
- [ ] Add the final launcher icon and splash artwork after PSD export.

**Exit criteria:** The app builds and launches on both mobile targets with the main route structure in place.

## Phase 3: Interactive Prototype

- [x] Implement the green geometric visual system and responsive phone layout.
- [x] Implement the home menu and persistent bottom navigation.
- [x] Implement chapter selection.
- [x] Implement the translation reader view.
- [x] Implement reciter selection view.
- [x] Implement settings language toggle.
- [x] Implement About Mawlid and About App views.
- [x] Add basic screen interaction states.
- [ ] Replace placeholder text with verified workbook/PDF content.
- [x] Load verified English workbook content into the Flutter reader.
- [ ] Stabilize async chapter loading for tests and device flow.
- [ ] Add real chapter pagination and reading position state.

**Exit criteria:** A user can move through every screenshot-visible flow from the home screen without dead ends.

## Phase 4: Content and Audio

- [ ] Parse the six chapter PDFs into structured chapter content.
- [ ] Convert the six Kannada workbooks into app-ready structured content.
- [x] Convert the six English workbooks into app-ready structured content.
- [ ] Add Malayalam, Kannada, and English content where available.
- [ ] Inspect the supplied hadis archive for Q&A and explanation content.
- [ ] Identify or recover reciter audio files from the supplied archives.
- [ ] Add audio playback, pause, seek, selected reciter, and chapter audio state.
- [ ] Persist language, selected reciter, and last reading position locally.

**Exit criteria:** The app is useful offline with real text and working recitation playback.

## Phase 5: Visual Fidelity and Accessibility

- [ ] Compare each route against the supplied screenshots at phone dimensions.
- [ ] Tune typography, spacing, header ornament, menu tiles, and bottom navigation.
- [ ] Use exported PSD assets where CSS approximations are visibly insufficient.
- [ ] Add keyboard focus states and accessible labels.
- [ ] Verify text wrapping for Kannada, Malayalam, Arabic, and English.
- [ ] Check mobile, tablet, and desktop presentation.

**Exit criteria:** The prototype matches the supplied visual references closely and remains readable and usable across target sizes.

## Phase 6: Verification and Release

- [ ] Run Flutter analyzer and widget tests for every route and primary interaction.
- [ ] Build and smoke test Android debug/release output.
- [ ] Build and smoke test iOS output on macOS/Xcode or a connected CI runner.
- [ ] Test offline loading with all required assets bundled locally.
- [ ] Add install/build instructions and document content licensing/source ownership.

**Exit criteria:** The rebuilt app can be handed off with reproducible setup, tested flows, and a clear packaging path.

## Tracking

| Phase | Status | Current blocker | Next action |
| --- | --- | --- | --- |
| 1. Reference Audit | In progress | Kannada normalization and PSD export remain | Normalize translations, export needed artwork |
| 2. Flutter Mobile Foundation | In progress | Launcher and splash artwork remain | Export branding artwork when tooling is available |
| 3. Interactive Prototype | In progress | Async chapter asset loading in widget test still needs final stabilization | Stabilize content-loading flow and complete route verification |
| 4. Content and Audio | In progress | Kannada encoding and audio source need confirmation | Normalize Kannada and inspect audio |
| 5. Visual Fidelity | Not started | Needs device screenshot comparison | Capture Android/iOS screens |
| 6. Verification and Release | Not started | Device/build targets need setup | Run analyzer and mobile builds |

## Current Files

- `index.html`, `styles.css`, and `app.js` - temporary browser visual prototype and interaction reference.
- `pubspec.yaml`, `lib/main.dart`, `android/`, and `ios/` - Flutter mobile project foundation.
- `reciter_bg.png` and `reciter_header_bg.png` - supplied pattern assets.
- `thahatangal pic.png` - supplied reciter image asset.
- `Kannada/1 K.xlsx` through `Kannada/6 dua.xlsx` - chapter-wise Kannada translation and explanation source.
- `english/1 Eng.xlsx` through `english/6 Eng.xlsx` - chapter-wise English translation source.
- `manqusmawlidpdf/Chapter 1.pdf` through `chapter 6 dua.pdf` - chapter-wise Arabic/source PDF material.
- `PHASE1_AUDIT.md` - verified source mapping, workbook schema, encoding findings, and design dimensions.
- `tool/convert_xlsx_sources.py` - offline converter for English workbook content.
- `assets/content/chapters.json` - generated UTF-8 English chapter content used by the Flutter reader.

## Decisions Needed Later

1. Are the Kannada workbook values intentionally stored in a legacy encoding, or should they be converted to Unicode Kannada?
2. Are the supplied reciter recordings available inside the archives, or do they need to be sourced separately?
3. Should the restored app preserve the original Kannada-first experience or add a Malayalam-first option?
4. What Android application ID and iOS bundle identifier should the release use?

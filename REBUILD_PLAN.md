# Manqoos Mawlid Rebuild Plan

## Goal

Rebuild the Manqoos Mawlid experience in Flutter for both iOS and Android from the provided App Store reference, screenshots, PSD designs, reciter assets, and Mawlid PDFs. The first milestone is a faithful mobile prototype with working navigation and reading interactions, followed by real offline content and audio.

## Phase 1: Reference Audit

- [x] Review App Store description and visible feature set.
- [x] Inventory supplied PSD, image, PDF, ZIP, and archive files.
- [x] Review supplied screenshots for home, chapters, reader, reciter, settings, and about flows.
- [x] Identify the final source text and chapter boundaries from the supplied PDFs.
- [x] Locate chapter-wise Kannada and English translation workbooks.
- [ ] Normalize and verify legacy-encoded Kannada cells before publishing them in Flutter.
- [ ] Extract or export any reusable PSD artwork that improves fidelity.

**Exit criteria:** The product surface, content sources, and visual assets are mapped well enough to implement without guessing at primary screens.

## Phase 2: Flutter Mobile Foundation

- [x] Create the Flutter project with iOS and Android targets.
- [ ] Define the app theme, typography, colors, and reusable ornamental widgets.
- [ ] Bundle supplied image assets through Flutter asset configuration.
- [ ] Set up a route/state structure for home, chapters, reader, reciter, settings, and about screens.
- [ ] Add Android and iOS app metadata, launcher icon, and splash treatment.

**Exit criteria:** The app builds and launches on both mobile targets with the main route structure in place.

## Phase 3: Interactive Prototype

- [ ] Implement the green geometric visual system and responsive phone layout.
- [ ] Implement the home menu and persistent bottom navigation.
- [ ] Implement chapter selection.
- [ ] Implement the translation reader view.
- [ ] Implement reciter selection view.
- [ ] Implement settings language toggle.
- [ ] Implement About Mawlid and About App views.
- [ ] Add basic share/copy feedback states.
- [ ] Replace placeholder text with verified workbook/PDF content.
- [ ] Add real chapter pagination and reading position state.

**Exit criteria:** A user can move through every screenshot-visible flow from the home screen without dead ends.

## Phase 4: Content and Audio

- [ ] Parse the six chapter PDFs into structured chapter content.
- [ ] Convert the six Kannada workbooks into app-ready structured content.
- [ ] Convert the six English workbooks into app-ready structured content.
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
| 1. Reference Audit | In progress | Kannada workbook encoding needs verification | Normalize translation source files |
| 2. Flutter Mobile Foundation | In progress | Theme and reusable widgets are still default | Define the Flutter theme |
| 3. Interactive Prototype | Not started | Flutter screens need implementation | Port the visual prototype |
| 4. Content and Audio | Not started | Audio source not yet confirmed | Inspect archives |
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

## Decisions Needed Later

1. Are the Kannada workbook values intentionally stored in a legacy encoding, or should they be converted to Unicode Kannada?
2. Are the supplied reciter recordings available inside the archives, or do they need to be sourced separately?
3. Should the restored app preserve the original Kannada-first experience or add a Malayalam-first option?
4. What Android application ID and iOS bundle identifier should the release use?

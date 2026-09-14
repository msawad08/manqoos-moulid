# Phase 1 Reference Audit

## Source Map

| Chapter | Arabic/source PDF | Kannada workbook | English workbook |
| --- | --- | --- | --- |
| 1 | `manqusmawlidpdf/Chapter 1.pdf` | `Kannada/1 K.xlsx` | `english/1 Eng.xlsx` |
| 2 | `manqusmawlidpdf/Chapter 2.pdf` | `Kannada/2 K.xlsx` | `english/2 Eng.xlsx` |
| 3 | `manqusmawlidpdf/Chapter 3.pdf` | `Kannada/3 K.xlsx` | `english/3 Eng.xlsx` |
| 4 | `manqusmawlidpdf/Chapter 4.pdf` | `Kannada/4 K.xlsx` | `english/4 Eng.xlsx` |
| 5 | `manqusmawlidpdf/Chapter 5.pdf` | `Kannada/5 K.xlsx` | `english/5 eng.xlsx` |
| 6 / Dua | `manqusmawlidpdf/chapter 6 dua.pdf` | `Kannada/6  dua.xlsx` | `english/6 eng Dua.xlsx` |

## Workbook Findings

- Kannada files use `Sheet1` with columns `Arabic`, `KANNADA TRANSLATION`, and `EXPLANATION`.
- English files use `Sheet1`; the first column is English translation and the second column is Arabic. Chapter 1 also contains a second sheet.
- The first row is content in the English workbooks and a header row in the Kannada workbooks, so conversion must be language-aware.
- Approximate non-empty row counts are: Kannada 25, 25, 25, 25, 34, and 2; English 26, 37, 26, 36, 38, and 26.
- The supplied Kannada translation cells contain no characters from the Unicode Kannada block (`U+0C80` to `U+0CFF`). They are legacy-encoded text, likely dependent on the original Kannada font/encoding.
- The Arabic source text is present in both language workbooks and should be retained as the alignment key during conversion.

## Implementation Consequences

1. Do not load `.xlsx` files in the production Flutter app. Convert them offline into UTF-8 JSON or Dart data files during the content pipeline.
2. Preserve chapter, row, Arabic, translation, and explanation fields in the generated model so the reader can support translation and explanation modes.
3. Treat Kannada normalization as a blocking content task. The legacy text must be converted with the correct source encoding/font mapping and reviewed visually before release.
4. Keep English chapter 1's second worksheet available for manual review; it may contain supplementary material.
5. Keep the chapter PDFs as the visual/source reference until the generated text is checked against them.

## Design Findings

- All screen PSDs are 1080x1920 portrait designs: welcome, menu, chapter list, reader/chapter, reciter, settings/about surfaces.
- `M Mawlid Icon.psd` is 1332x1632 and should be exported to a mobile launcher/splash asset rather than loaded at runtime as a PSD.
- Existing PNG assets include the reciter background, ornamental header background, and reciter portrait reference.

## Phase 1 Status

Reference mapping and schema inspection are complete. Remaining Phase 1 work is limited to Kannada legacy-encoding normalization/verification and exporting any PSD artwork that materially improves the Flutter implementation.

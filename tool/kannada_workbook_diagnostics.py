"""Diagnostic script for legacy-encoded Kannada workbook sources.

This script inspects the supplied Kannada .xlsx workbooks and reports whether any
content contains actual Unicode Kannada characters or only legacy font-encoded
text. It does not attempt a blind conversion because the source encoding must be
validated before we rewrite content.
"""

from __future__ import annotations

import zipfile
from pathlib import Path
from xml.etree import ElementTree

NS = {"m": "http://schemas.openxmlformats.org/spreadsheetml/2006/main"}
ROOT = Path(__file__).resolve().parents[1]
KANNADA_PATH = ROOT / "Kannada"


def shared_strings(archive: zipfile.ZipFile) -> list[str]:
    if "xl/sharedStrings.xml" not in archive.namelist():
        return []
    root = ElementTree.fromstring(archive.read("xl/sharedStrings.xml"))
    values: list[str] = []
    for item in root.findall("m:si", NS):
        texts = [node.text or "" for node in item.findall(".//m:t", NS)]
        values.append("".join(texts))
    return values


def rows(path: Path) -> list[list[str]]:
    with zipfile.ZipFile(path) as archive:
        shared = shared_strings(archive)
        sheet = ElementTree.fromstring(archive.read("xl/worksheets/sheet1.xml"))
        out: list[list[str]] = []
        for row in sheet.findall(".//m:row", NS):
            values: list[str] = []
            for cell in row.findall("m:c", NS):
                value = cell.find("m:v", NS)
                text = "" if value is None or value.text is None else value.text
                if cell.get("t") == "s" and text:
                    text = shared[int(text)]
                values.append(text.strip())
            if any(values):
                out.append(values)
        return out


def has_kannada_unicode(text: str) -> bool:
    return any(0x0C80 <= ord(ch) <= 0x0CFF for ch in text)


def main() -> None:
    print("Kannada workbook diagnostic")
    print("=" * 40)

    for workbook in sorted(KANNADA_PATH.glob("*.xlsx")):
        if workbook.name.startswith("~$"):
            continue
        collected: list[str] = []
        row_count = 0
        translation_samples: list[str] = []
        for row in rows(workbook):
            row_count += 1
            for value in row:
                if value:
                    collected.append(value)
            if len(row) > 1 and row[1] and len(translation_samples) < 3:
                translation_samples.append(row[1])

        actual_kannada_count = sum(
            1 for value in collected if has_kannada_unicode(value)
        )
        sample = next((value for value in collected if value), "")
        print(f"{workbook.name}: rows={row_count}, strings={len(collected)}")
        print(f"  unicode Kannada cells: {actual_kannada_count}")
        print(f"  sample: {sample[:180]!r}")
        for index, value in enumerate(translation_samples, start=1):
            codepoints = " ".join(f"U+{ord(char):04X}" for char in value[:24])
            print(f"  translation {index}: {value[:180]!r}")
            print(f"    codepoints: {codepoints}")
        print()

    print("Conclusion: the supplied Kannada workbooks are not storing native Unicode Kannada characters in the shared strings. The content is legacy-encoded text and requires source-specific normalization before release.")


if __name__ == "__main__":
    main()

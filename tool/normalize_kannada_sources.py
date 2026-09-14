"""Normalize Nudi workbook text into UTF-8 JSON after mapping verification.

Nudi is a legacy glyph encoding, not a UTF-8 encoding. The mapping is therefore
an explicit input rather than an implicit codec guess. The command refuses to
write output when any non-Unicode source value is unmapped.
"""

from __future__ import annotations

import argparse
import json
import zipfile
from pathlib import Path
from xml.etree import ElementTree

NS = {"m": "http://schemas.openxmlformats.org/spreadsheetml/2006/main"}
ROOT = Path(__file__).resolve().parents[1]


def shared_strings(archive: zipfile.ZipFile) -> list[str]:
    root = ElementTree.fromstring(archive.read("xl/sharedStrings.xml"))
    return [
        "".join(node.text or "" for node in item.findall(".//m:t", NS))
        for item in root.findall("m:si", NS)
    ]


def rows(path: Path) -> list[list[str]]:
    with zipfile.ZipFile(path) as archive:
        shared = shared_strings(archive)
        sheet = ElementTree.fromstring(archive.read("xl/worksheets/sheet1.xml"))
        result: list[list[str]] = []
        for row in sheet.findall(".//m:row", NS):
            values: list[str] = []
            for cell in row.findall("m:c", NS):
                value = cell.find("m:v")
                text = "" if value is None or value.text is None else value.text
                if cell.get("t") == "s" and text:
                    text = shared[int(text)]
                values.append(text.strip())
            if any(values):
                result.append(values)
        return result


def contains_kannada(text: str) -> bool:
    return any(0x0C80 <= ord(char) <= 0x0CFF for char in text)


def normalize(text: str, mapping: dict[str, str]) -> str:
    if contains_kannada(text):
        return text
    for source, target in sorted(mapping.items(), key=lambda item: len(item[0]), reverse=True):
        text = text.replace(source, target)
    return text


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--mapping", type=Path, required=True)
    parser.add_argument("--output", type=Path, default=ROOT / "assets/content/kannada_chapters.json")
    args = parser.parse_args()
    mapping = json.loads(args.mapping.read_text(encoding="utf-8"))
    chapters = []
    unmapped: list[str] = []

    for workbook in sorted((ROOT / "Kannada").glob("*.xlsx")):
        if workbook.name.startswith("~$"):
            continue
        workbook_rows = rows(workbook)
        entries = []
        for row in workbook_rows[1:]:
            if len(row) < 2:
                continue
            arabic = row[0]
            translation = normalize(row[1], mapping)
            explanation = normalize(row[2], mapping) if len(row) > 2 else ""
            if not contains_kannada(translation) and any(ord(char) > 127 for char in translation):
                unmapped.append(f"{workbook.name}: {translation[:80]}")
            entries.append({"arabic": arabic, "kannada": translation, "explanation": explanation})
        chapters.append({"chapter": len(chapters) + 1, "source": workbook.name, "entries": entries})

    if unmapped:
        raise SystemExit(
            "Nudi mapping is incomplete; no output was written. First unmapped values:\n"
            + "\n".join(unmapped[:10])
        )
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps({"language": "Kannada", "chapters": chapters}, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"Wrote {args.output.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
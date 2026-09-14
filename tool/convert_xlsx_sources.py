"""Convert chapter workbooks into UTF-8 JSON for the offline Flutter app.

The English workbooks are converted directly. Kannada values are preserved as
raw source fields because the supplied cells use a legacy font encoding and
must not be silently rewritten as if they were Unicode Kannada.
"""

from __future__ import annotations

import json
import zipfile
from pathlib import Path
from xml.etree import ElementTree

NAMESPACE = {"m": "http://schemas.openxmlformats.org/spreadsheetml/2006/main"}
ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "assets" / "content" / "chapters.json"


def repair_text(value: str) -> str:
    """Repair workbook text that was decoded as Latin-1 instead of UTF-8."""
    if not any(marker in value for marker in ("Ã", "Â", "Ø", "Ù", "â", "ï")):
        return value
    try:
        repaired = value.encode("latin1").decode("utf-8")
    except UnicodeError:
        return value
    return repaired


def shared_strings(archive: zipfile.ZipFile) -> list[str]:
    if "xl/sharedStrings.xml" not in archive.namelist():
        return []
    root = ElementTree.fromstring(archive.read("xl/sharedStrings.xml"))
    return [
        "".join(text.text or "" for text in item.findall(".//m:t", NAMESPACE))
        for item in root.findall("m:si", NAMESPACE)
    ]


def rows(path: Path) -> list[list[str]]:
    with zipfile.ZipFile(path) as archive:
        shared = shared_strings(archive)
        root = ElementTree.fromstring(archive.read("xl/worksheets/sheet1.xml"))
        result = []
        for row in root.findall(".//m:row", NAMESPACE):
            values = []
            for cell in row.findall("m:c", NAMESPACE):
                value = cell.find("m:v", NAMESPACE)
                text = "" if value is None else value.text or ""
                if cell.get("t") == "s" and text:
                    text = shared[int(text)]
                values.append(repair_text(text.strip()))
            if any(values):
                result.append(values)
        return result


def chapter_number(path: Path) -> int:
    digits = "".join(character for character in path.stem if character.isdigit())
    return int(digits or "0")


def english_chapter(path: Path) -> dict:
    entries = []
    for row in rows(path):
        if len(row) < 2:
            continue
        english, arabic = row[0], row[1]
        if english or arabic:
            entries.append({"arabic": arabic, "english": english})
    return {"chapter": chapter_number(path), "source": path.name, "entries": entries}


def main() -> None:
    chapters = [english_chapter(path) for path in sorted((ROOT / "english").glob("*.xlsx"))]
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(json.dumps({"language": "English", "chapters": chapters}, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"Wrote {OUTPUT.relative_to(ROOT)} with {sum(len(chapter['entries']) for chapter in chapters)} entries")


if __name__ == "__main__":
    main()

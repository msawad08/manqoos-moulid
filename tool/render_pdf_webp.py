"""Render supplied chapter PDFs into compact WebP page assets for Flutter."""

from __future__ import annotations

from pathlib import Path

import pymupdf
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "manqusmawlidpdf"
OUTPUT = ROOT / "assets" / "pdf_pages"
PNG_OUTPUT = ROOT / "assets" / "pdf_pages_png"

PDFS = [
    (1, "Chapter 1.pdf"),
    (2, "Chapter 2.pdf"),
    (3, "Chapter 3.pdf"),
    (4, "Chapter 4.pdf"),
    (5, "Chapter 5.pdf"),
    (6, "chapter 6 dua.pdf"),
]


def main() -> None:
    OUTPUT.mkdir(parents=True, exist_ok=True)
    PNG_OUTPUT.mkdir(parents=True, exist_ok=True)
    total = 0
    for chapter, filename in PDFS:
        chapter_dir = OUTPUT / f"chapter_{chapter}"
        png_chapter_dir = PNG_OUTPUT / f"chapter_{chapter}"
        chapter_dir.mkdir(exist_ok=True)
        png_chapter_dir.mkdir(exist_ok=True)
        document = pymupdf.open(SOURCE / filename)
        for page_number, page in enumerate(document, start=1):
            image = page.get_pixmap(matrix=pymupdf.Matrix(1.35, 1.35), alpha=False)
            bitmap = Image.frombytes("RGB", (image.width, image.height), image.samples)
            bitmap.save(
                chapter_dir / f"page_{page_number:02d}.webp",
                "WEBP",
                quality=78,
                method=6,
            )
            bitmap.save(
                png_chapter_dir / f"page_{page_number:02d}.png",
                "PNG",
                optimize=True,
            )
            total += 1
        print(f"chapter {chapter}: {len(document)} pages")
    print(f"rendered {total} WebP pages to {OUTPUT.relative_to(ROOT)}")


if __name__ == "__main__":
    main()

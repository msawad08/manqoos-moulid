import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ChapterDivider extends StatelessWidget {
  const ChapterDivider({super.key, required this.chapterNumber});
  final int chapterNumber;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(12, 18, 12, 14),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      color: brightGreen,
      borderRadius: BorderRadius.circular(6),
      image: const DecorationImage(
        image: AssetImage('reciter_bg.png'),
        fit: BoxFit.cover,
        opacity: .2,
      ),
    ),
    child: Text(
      chapterNumber == 6
          ? 'CHAPTER 06  ·  DUA'
          : 'CHAPTER ${chapterNumber.toString().padLeft(2, '0')}  ·  HADEES & BAITH',
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    ),
  );
}

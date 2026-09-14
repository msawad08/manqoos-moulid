import 'package:flutter/material.dart';

const deepGreen = Color(0xff087509);
const brightGreen = Color(0xff16820c);
const paleGreen = Color(0xffd7e99d);

ThemeData buildAppTheme() => ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: brightGreen),
  useMaterial3: true,
  fontFamily: 'Georgia',
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontFamily: 'NotoSansKannada'),
    bodyMedium: TextStyle(fontFamily: 'NotoSansKannada'),
  ),
);

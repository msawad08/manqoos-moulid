import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PatternBody extends StatelessWidget {
  const PatternBody({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      color: brightGreen,
      image: DecorationImage(
        image: AssetImage('reciter_bg.png'),
        fit: BoxFit.cover,
        opacity: .35,
      ),
    ),
    padding: const EdgeInsets.all(20),
    child: child,
  );
}

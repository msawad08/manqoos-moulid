import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GreenHeader extends StatelessWidget {
  const GreenHeader({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) => Container(
    height: title == null ? 290 : 110,
    width: double.infinity,
    decoration: const BoxDecoration(
      color: brightGreen,
      image: DecorationImage(
        image: AssetImage('reciter_header_bg.png'),
        fit: BoxFit.cover,
        opacity: .32,
      ),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        if (title != null)
          Positioned(
            left: 8,
            top: 22,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              color: Colors.white,
              icon: const Icon(Icons.arrow_back, size: 30),
            ),
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title ?? 'ISLAMIC WAY',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (title == null)
              const Text(
                'The Solution for Humanity',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            if (title == null) ...const [
              SizedBox(height: 24),
              Text(
                '12 SEPTEMBER 2026',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '00:46',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ],
          ],
        ),
        Positioned(
          bottom: -44,
          left: 55,
          right: 55,
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(100),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

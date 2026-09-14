import 'dart:math' as math;
import 'package:flutter/material.dart';

class IslamicStarAvatar extends StatelessWidget {
  const IslamicStarAvatar({
    super.key,
    required this.imagePath,
    this.size = 80,
    this.isSelected = true,
  });

  final String imagePath;
  final double size;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: size * 0.76,
              height: size * 0.76,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: isSelected
                    ? const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
            ),
          ),
          Container(
            width: size * 0.76,
            height: size * 0.76,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: size * 0.70,
              height: size * 0.70,
              decoration: BoxDecoration(
                color: const Color(0xff0b5e0c),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          Container(
            width: size * 0.70,
            height: size * 0.70,
            decoration: BoxDecoration(
              color: const Color(0xff0b5e0c),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(size / 2),
            child: Container(
              width: size * 0.68,
              height: size * 0.68,
              color: isSelected ? Colors.white10 : Colors.black12,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

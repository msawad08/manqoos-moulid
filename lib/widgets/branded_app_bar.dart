import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BrandedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BrandedAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.onBack,
  });

  final String title;
  final String? subtitle;
  final Widget? action;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(94);

  @override
  Widget build(BuildContext context) => Container(
    height: preferredSize.height,
    decoration: const BoxDecoration(
      color: brightGreen,
      image: DecorationImage(
        image: AssetImage('reciter_header_bg.png'),
        fit: BoxFit.cover,
        opacity: .3,
      ),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
    ),
    child: SafeArea(
      bottom: false,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (onBack != null) {
                onBack!();
              } else if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            color: Colors.white,
            icon: const Icon(Icons.arrow_back, size: 30),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
              ],
            ),
          ),
          action ?? const SizedBox(width: 12),
        ],
      ),
    ),
  );
}

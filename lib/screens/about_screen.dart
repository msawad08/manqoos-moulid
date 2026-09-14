import 'package:flutter/material.dart';
import '../data/about_data.dart';
import '../models/app_settings.dart';
import '../theme/app_theme.dart';
import '../widgets/branded_app_bar.dart';
import '../widgets/pattern_body.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<AppSettings>(
    valueListenable: appSettings,
    builder: (context, settings, _) {
      final entry = AboutData.get(title, settings.language);
      final fontSize = settings.fontSize.aboutFontSize;

      return Scaffold(
        appBar: BrandedAppBar(
          title: title,
          subtitle: entry.subtitle,
        ),
        body: PatternBody(
          child: ListView(
            children: [
              // Summary card
              Container(
                margin: const EdgeInsets.only(bottom: 18),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title,
                      style: const TextStyle(
                        color: deepGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      entry.subtitle,
                      style: TextStyle(
                        color: brightGreen.withValues(alpha: 0.85),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Divider(height: 24, thickness: 1, color: Colors.black12),
                    Text(
                      entry.summary,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: fontSize,
                        height: 1.55,
                        fontFamily: 'NotoSansKannada',
                      ),
                    ),
                  ],
                ),
              ),
              // Section cards
              for (final section in entry.sections)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: paleGreen.withValues(alpha: 0.6), width: 1.5),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.stars, color: deepGreen, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              section.heading,
                              style: const TextStyle(
                                color: deepGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        section.body,
                        style: TextStyle(
                          color: const Color(0xff222222),
                          fontSize: fontSize,
                          height: 1.6,
                          fontFamily: 'NotoSansKannada',
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
    },
  );
}

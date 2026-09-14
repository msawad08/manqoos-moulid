import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/audio_bar.dart';
import '../widgets/branded_app_bar.dart';
import '../widgets/chapter_divider.dart';
import 'settings_screen.dart';

class ArabicPdfScreen extends StatefulWidget {
  const ArabicPdfScreen({
    super.key,
    required this.chapterNumber,
    this.onBack,
  });

  final int chapterNumber;
  final VoidCallback? onBack;

  @override
  State<ArabicPdfScreen> createState() => _ArabicPdfScreenState();
}

class _ArabicPdfScreenState extends State<ArabicPdfScreen> {
  final scrollController = ScrollController();
  final chapterKeys = <int, GlobalKey>{};

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (var chapter = 1; chapter <= 6; chapter++) {
      chapterKeys.putIfAbsent(chapter, GlobalKey.new);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final target = chapterKeys[widget.chapterNumber]?.currentContext;
      if (target != null && scrollController.hasClients) {
        Scrollable.ensureVisible(
          target,
          duration: const Duration(milliseconds: 1),
        );
      }
    });
    final chapters = orderedChapterNumbers(widget.chapterNumber);
    return Scaffold(
      appBar: BrandedAppBar(
        title: 'Mawlid',
        subtitle: 'Arabic pages',
        onBack: widget.onBack,
        action: IconButton(
          tooltip: 'Settings',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
          ),
          icon: const Icon(Icons.settings, color: Colors.white, size: 28),
        ),
      ),
      body: ListView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          for (final chapter in chapters) ...[
            ChapterDivider(key: chapterKeys[chapter], chapterNumber: chapter),
            for (final asset in chapterPageAssets(chapter))
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: deepGreen,
                    border: Border.all(color: paleGreen, width: 2),
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('reciter_bg.png'),
                      fit: BoxFit.cover,
                      opacity: .55,
                    ),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 5),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Image.asset(asset, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
      bottomNavigationBar: const AudioBar(),
    );
  }
}

List<String> chapterPageAssets(int chapter) {
  const pageCounts = [0, 3, 3, 3, 2, 4, 2];
  return [
    for (var page = 1; page <= pageCounts[chapter]; page++)
      'assets/pdf_pages_png/chapter_$chapter/page_${page.toString().padLeft(2, '0')}.png',
  ];
}

List<int> orderedChapterNumbers(int selected) => [
  for (var chapter = selected; chapter <= 6; chapter++) chapter,
  for (var chapter = 1; chapter < selected; chapter++) chapter,
];

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../content.dart';
import '../models/app_settings.dart';
import '../theme/app_theme.dart';
import '../widgets/branded_app_bar.dart';
import '../widgets/chapter_divider.dart';
import '../widgets/reader_action_bar.dart';
import 'settings_screen.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key, this.chapterNumber = 1, this.onBack});

  final int chapterNumber;
  final VoidCallback? onBack;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  bool showExplanation = false;
  bool selectedHasExplanation = false;
  int? selectedChapterNumber;
  int? selectedEntryIndex;
  final scrollController = ScrollController();
  final chapterKeys = <int, GlobalKey>{};

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<AppSettings>(
    valueListenable: appSettings,
    builder: (context, settings, _) => Scaffold(
      appBar: BrandedAppBar(
        title: 'Mawlid',
        subtitle: 'Translation',
        onBack: widget.onBack,
        action: IconButton(
          tooltip: 'Settings',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
          ),
          icon: const Icon(Icons.settings, color: Colors.white, size: 28),
        ),
      ),
      body: FutureBuilder<MawlidContent>(
        future: settings.language == 'Kannada'
            ? MawlidContent.loadKannada()
            : MawlidContent.loadEnglish(),
        builder: (context, snapshot) {
          final content = snapshot.data ?? MawlidContent.fallbackEnglish();
          final chapters = orderedChapters(
            content.chapters,
            widget.chapterNumber,
          );
          for (final chapter in chapters) {
            chapterKeys.putIfAbsent(chapter.number, GlobalKey.new);
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

          return ListView(
            controller: scrollController,
            children: [
              for (final chapter in chapters) ...[
                ChapterDivider(
                  key: chapterKeys[chapter.number],
                  chapterNumber: chapter.number,
                ),
                for (
                  var entryIndex = 0;
                  entryIndex < chapter.entries.length;
                  entryIndex++
                )
                  _buildVerse(
                    settings,
                    chapter,
                    entryIndex,
                    chapter.entries[entryIndex],
                  ),
              ],
              const SizedBox(height: 86),
            ],
          );
        },
      ),
      bottomNavigationBar: ReaderActionBar(
        showExplanation: showExplanation,
        explanationEnabled: selectedHasExplanation,
        reciter: settings.reciter,
        onExplanation: () => _showExplanation(context, settings),
        onCopy: () => _copySelectedEntry(context),
        onShare: () => _shareSelectedEntry(context),
      ),
    ),
  );

  Future<MawlidContent> _loadContent() =>
      appSettings.value.language == 'Kannada'
      ? MawlidContent.loadKannada()
      : MawlidContent.loadEnglish();

  MawlidEntry? _selectedEntry(MawlidContent? content) {
    if (content == null ||
        selectedChapterNumber == null ||
        selectedEntryIndex == null) {
      return null;
    }
    final chapter = content.chapters.firstWhere(
      (entry) => entry.number == selectedChapterNumber,
      orElse: () => content.chapters.first,
    );
    if (selectedEntryIndex! >= chapter.entries.length) return null;
    return chapter.entries[selectedEntryIndex!];
  }

  Widget _buildVerse(
    AppSettings settings,
    MawlidChapter chapter,
    int entryIndex,
    MawlidEntry entry,
  ) {
    final selected =
        selectedChapterNumber == chapter.number &&
        selectedEntryIndex == entryIndex;
    final translation =
        settings.language == 'Kannada' && entry.kannada.isNotEmpty
        ? entry.kannada
        : entry.english;

    return GestureDetector(
      onTap: () => setState(() {
        selectedChapterNumber = chapter.number;
        selectedEntryIndex = entryIndex;
        selectedHasExplanation = entry.explanation.isNotEmpty;
        showExplanation = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        color: selected ? paleGreen.withValues(alpha: .7) : Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                entry.arabic,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: settings.mushafArabic
                      ? 'NotoNaskhArabic'
                      : 'Amiri',
                  fontSize: 25,
                  color: deepGreen,
                ),
              ),
            ),
            ReaderVerse(
              text: translation,
              selected: selected,
              fontSize: settings.fontSize.translationFontSize,
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _selectedText() async {
    final content = await _loadContent();
    final entry = _selectedEntry(content);
    if (entry == null) return null;
    final translation =
        appSettings.value.language == 'Kannada' && entry.kannada.isNotEmpty
        ? entry.kannada
        : entry.english;
    return '${entry.arabic}\n$translation${entry.explanation.isEmpty ? '' : '\n${entry.explanation}'} \n\nRead More on Manqoos Mawlid App by Islamic Way. Download the app now: https://itsallwidgets.com/manqoos-mawlid';
  }

  Future<void> _copySelectedEntry(BuildContext context) async {
    final text = await _selectedText();
    if (text == null) return;
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Verse copied')));
    }
  }

  Future<void> _showExplanation(
    BuildContext context,
    AppSettings settings,
  ) async {
    final content = await _loadContent();
    final entry = _selectedEntry(content);
    if (entry == null || entry.explanation.isEmpty || !context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Explanation'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Text(
              entry.explanation,
              style: TextStyle(
                color: deepGreen,
                fontFamily: 'NotoSansKannada',
                fontSize: settings.fontSize.explanationFontSize,
                height: 1.5,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  Future<void> _shareSelectedEntry(BuildContext context) async {
    final text = await _selectedText();
    if (text == null) return;
    await SharePlus.instance.share(
      ShareParams(text: text, subject: 'Manqoos Mawlid verse'),
    );
  }
}

class ReaderVerse extends StatelessWidget {
  const ReaderVerse({
    super.key,
    required this.text,
    this.selected = false,
    this.fontSize = 18.0,
  });

  final String text;
  final bool selected;
  final double fontSize;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      border: const Border(top: BorderSide(color: Colors.black12)),
      color: selected ? paleGreen.withValues(alpha: .35) : null,
    ),
    child: Text(
      text,
      style: TextStyle(
        color: deepGreen,
        fontFamily: 'NotoSansKannada',
        fontSize: fontSize,
        height: 1.55,
      ),
    ),
  );
}

List<MawlidChapter> orderedChapters(
  List<MawlidChapter> chapters,
  int selected,
) => [
  ...chapters.where((chapter) => chapter.number >= selected),
  ...chapters.where((chapter) => chapter.number < selected),
];

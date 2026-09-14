import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import 'content.dart';

const deepGreen = Color(0xff087509);
const brightGreen = Color(0xff16820c);
const paleGreen = Color(0xffd7e99d);

final appSettings = ValueNotifier(const AppSettings());
final currentChapter = ValueNotifier(1);

class AppSettings {
  const AppSettings({
    this.translationEnabled = true,
    this.mushafArabic = true,
    this.language = 'Kannada',
    this.reciter = 'Sayyid Thaha Tangal Pookkottur / Hafiz Nizamuddeen Mahmoodi',
  });

  final bool translationEnabled;
  final bool mushafArabic;
  final String language;
  final String reciter;

  AppSettings copyWith({
    bool? translationEnabled,
    bool? mushafArabic,
    String? language,
    String? reciter,
  }) =>
      AppSettings(
        translationEnabled: translationEnabled ?? this.translationEnabled,
        mushafArabic: mushafArabic ?? this.mushafArabic,
        language: language ?? this.language,
        reciter: reciter ?? this.reciter,
      );
}

class HomeMenuItem {
  const HomeMenuItem({required this.icon, required this.label, this.page});

  final IconData icon;
  final String label;
  final Widget? page;
}

void main() => runApp(const ManqoosApp());

class ManqoosApp extends StatelessWidget {
  const ManqoosApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Manqoos Mawlid',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: brightGreen),
      useMaterial3: true,
      fontFamily: 'Georgia',
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontFamily: 'NotoSansKannada'),
        bodyMedium: TextStyle(fontFamily: 'NotoSansKannada'),
      ),
    ),
    home: const HomeScreen(),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      bottom: false,
      child: selectedTab == 0
          ? const HomeContent()
          : selectedTab == 1
          ? ValueListenableBuilder<AppSettings>(
              valueListenable: appSettings,
              builder: (context, settings, _) => ValueListenableBuilder<int>(
                valueListenable: currentChapter,
                builder: (context, chapter, _) => settings.translationEnabled
                    ? ReaderScreen(chapterNumber: chapter)
                    : ArabicPdfScreen(chapterNumber: chapter),
              ),
            )
          : const SettingsScreen(),
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: selectedTab,
      onDestinationSelected: (index) => setState(() => selectedTab = index),
      indicatorColor: paleGreen,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'HOME'),
        NavigationDestination(
          icon: Icon(Icons.menu_book_outlined),
          label: 'MAWLID',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          label: 'SETTINGS',
        ),
      ],
    ),
  );
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <HomeMenuItem>[
      HomeMenuItem(icon: Icons.menu_book, label: 'Mawlid', page: const ChaptersScreen()),
      HomeMenuItem(icon: Icons.grid_view, label: 'Q&A', page: const AboutScreen(title: 'Q&A')),
      HomeMenuItem(icon: Icons.info_outline, label: 'About Mawlid', page: const AboutScreen(title: 'About Mawlid')),
      HomeMenuItem(icon: Icons.record_voice_over, label: 'Reciter', page: const ReciterScreen()),
      HomeMenuItem(icon: Icons.settings, label: 'Settings', page: const SettingsScreen()),
      HomeMenuItem(icon: Icons.phone_android, label: 'About App', page: const AboutScreen(title: 'About App')),
      HomeMenuItem(icon: Icons.people, label: 'About Us', page: const AboutScreen(title: 'About Us')),
      const HomeMenuItem(icon: Icons.share, label: 'Share'),
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          const GreenHeader(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 36, 20, 30),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 28,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  final item = items[index];
                  if (item.page != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (_) => item.page!),
                    );
                  } else {
                    SharePlus.instance.share(
                      ShareParams(text: 'Explore Manqoos Mawlid with Islamic Way.'),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  children: [
                    Transform.rotate(
                      angle: .785,
                      child: Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xffb8e58a), deepGreen],
                          ),
                          border: Border.all(color: Colors.black, width: 4),
                          borderRadius: BorderRadius.circular(17),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0, 5),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Transform.rotate(
                          angle: -.785,
                          child: Icon(
                            items[index].icon,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 17),
                    Text(
                      items[index].label.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: deepGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chapters')),
      body: FutureBuilder<MawlidContent>(
        future: MawlidContent.loadEnglish(),
        builder: (context, snapshot) {
          final content = snapshot.data ?? MawlidContent.fallbackEnglish();
          final chapters = content.chapters;
          return PatternBody(
            child: ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapter = chapters[index];
                final label = chapter.number == 6 ? 'Dua' : 'Hadees & Baith';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: OutlinedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) {
                          currentChapter.value = chapter.number;
                          return ValueListenableBuilder<AppSettings>(
                            valueListenable: appSettings,
                            builder: (context, settings, _) =>
                                settings.translationEnabled
                                ? ReaderScreen(chapterNumber: chapter.number)
                                : ArabicPdfScreen(
                                    chapterNumber: chapter.number,
                                  ),
                          );
                        },
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      minimumSize: const Size.fromHeight(58),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Chapter ${chapter.number}  $label',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ReciterScreen extends StatelessWidget {
  const ReciterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final names = [
      'Sayyid Thaha Tangal Pookkottur / Hafiz Nizamuddeen Mahmoodi',
      'Arif Sa\'adi Katipalla',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Reciter')),
      body: PatternBody(
        child: Column(
          children: names
              .map(
                (name) => ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.play_arrow, color: deepGreen),
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    appSettings.value = appSettings.value.copyWith(reciter: name);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$name selected')),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<AppSettings>(
    valueListenable: appSettings,
    builder: (context, settings, _) => Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Translation language',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              DropdownButton<String>(
                value: settings.language,
                items: const [
                  DropdownMenuItem(value: 'Kannada', child: Text('Kannada')),
                  DropdownMenuItem(value: 'English', child: Text('English')),
                ],
                onChanged: (value) => appSettings.value = settings.copyWith(
                  language: value,
                ),
              ),
            ],
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Show translation'),
            subtitle: const Text('When disabled, open the Arabic chapter PDF'),
            value: settings.translationEnabled,
            onChanged: (value) => appSettings.value = settings.copyWith(
              translationEnabled: value,
            ),
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Mushaf Arabic font'),
            subtitle: const Text('Use Noto Naskh Arabic instead of Amiri'),
            value: settings.mushafArabic,
            onChanged: (value) => appSettings.value = settings.copyWith(
              mushafArabic: value,
            ),
          ),
        ],
      ),
    ),
  );
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: PatternBody(
      child: SingleChildScrollView(
        child: Text(
          _aboutText(title),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            height: 1.55,
            fontFamily: 'NotoSansKannada',
          ),
        ),
      ),
    ),
  );
}

String _aboutText(String title) => switch (title) {
  'About Mawlid' => 'Mawlid is a collection of praise, remembrance, and lessons connected to the beloved Prophet Muhammad, peace be upon him. Read the Arabic source with Kannada or English translation, or open the original chapter PDF.',
  'Q&A' => 'Find the explanation and context for each chapter in the reader. The explanation action keeps the Arabic and translation together so the meaning can be read without losing the original text.',
  'About Us' => 'Islamic Way brings useful Islamic reading, translation, and recitation resources together in one offline-friendly app.',
  _ => 'Manqoos Mawlid is a local-first Flutter app for Android and iOS with chapter reading, Kannada and English translations, Arabic PDFs, reciter selection, and sharing.',
};

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key, this.chapterNumber = 1});

  final int chapterNumber;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  bool showExplanation = false;
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
      appBar: AppBar(title: const Text('Mawlid')),
      body: FutureBuilder<MawlidContent>(
        future: settings.language == 'Kannada'
          ? MawlidContent.loadKannada()
          : MawlidContent.loadEnglish(),
      builder: (context, snapshot) {
        final content = snapshot.data ?? MawlidContent.fallbackEnglish();
        final chapters = orderedChapters(content.chapters, widget.chapterNumber);
        for (final chapter in chapters) {
          chapterKeys.putIfAbsent(chapter.number, GlobalKey.new);
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final target = chapterKeys[widget.chapterNumber]?.currentContext;
          if (target != null && scrollController.hasClients) {
            Scrollable.ensureVisible(target, duration: const Duration(milliseconds: 1));
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
              ...chapter.entries.map(
                (entry) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        entry.arabic,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: settings.mushafArabic ? 'NotoNaskhArabic' : 'Amiri',
                          fontSize: 25,
                          color: deepGreen,
                        ),
                      ),
                    ),
                    ReaderVerse(
                      text: settings.language == 'Kannada' && entry.kannada.isNotEmpty
                          ? entry.kannada
                          : entry.english,
                    ),
                    if (showExplanation && entry.explanation.isNotEmpty)
                      ExplanationBlock(text: entry.explanation),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 86),
          ],
        );
      },
    ),
      bottomNavigationBar: ReaderActionBar(
        showExplanation: showExplanation,
        reciter: settings.reciter,
        onExplanation: () => setState(() => showExplanation = !showExplanation),
        onCopy: () => _copyChapter(context),
        onShare: () => _shareChapter(context),
      ),
    ),
  );

  Future<MawlidContent> _loadContent() => appSettings.value.language == 'Kannada'
      ? MawlidContent.loadKannada()
      : MawlidContent.loadEnglish();

  Future<String> _chapterText() async {
    final content = await _loadContent();
    final chapter = content.chapters.firstWhere(
      (entry) => entry.number == widget.chapterNumber,
      orElse: () => content.chapters.first,
    );
    return chapter.entries.map((entry) {
      final translation = appSettings.value.language == 'Kannada' && entry.kannada.isNotEmpty
          ? entry.kannada
          : entry.english;
      return '${entry.arabic}\n$translation${entry.explanation.isEmpty ? '' : '\n${entry.explanation}'}';
    }).join('\n\n');
  }

  Future<void> _copyChapter(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: await _chapterText()));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Chapter copied')));
    }
  }

  Future<void> _shareChapter(BuildContext context) async {
    await SharePlus.instance.share(
      ShareParams(
        text: await _chapterText(),
        subject: 'Manqoos Mawlid Chapter ${widget.chapterNumber}',
      ),
    );
  }
}

class ExplanationBlock extends StatelessWidget {
  const ExplanationBlock({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(18, 0, 18, 14),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: paleGreen.withValues(alpha: .45),
      border: Border.all(color: brightGreen.withValues(alpha: .35)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(text, style: const TextStyle(color: deepGreen, height: 1.45)),
  );
}

class ReaderActionBar extends StatelessWidget {
  const ReaderActionBar({super.key, required this.showExplanation, required this.reciter, required this.onExplanation, required this.onCopy, required this.onShare});
  final bool showExplanation;
  final String reciter;
  final VoidCallback onExplanation;
  final VoidCallback onCopy;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) => Material(
    color: brightGreen,
    child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                IconButton(onPressed: () {}, color: Colors.white, icon: const Icon(Icons.play_circle_fill)),
                IconButton(onPressed: () {}, color: Colors.white, icon: const Icon(Icons.stop_circle)),
                Expanded(child: Text(reciter, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Row(
            children: [
              _ReaderAction(icon: Icons.article, label: 'EXPLANATION', active: showExplanation, onPressed: onExplanation),
              _ReaderAction(icon: Icons.copy, label: 'COPY', onPressed: onCopy),
              _ReaderAction(icon: Icons.share, label: 'SHARE', onPressed: onShare),
            ],
          ),
        ],
      ),
    ),
  );
}

class _ReaderAction extends StatelessWidget {
  const _ReaderAction({required this.icon, required this.label, required this.onPressed, this.active = false});
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool active;

  @override
  Widget build(BuildContext context) => Expanded(
    child: TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: active ? paleGreen : Colors.white),
      label: Text(label, style: TextStyle(color: active ? paleGreen : Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}

class ArabicPdfScreen extends StatefulWidget {
  const ArabicPdfScreen({super.key, required this.chapterNumber});

  final int chapterNumber;

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
        Scrollable.ensureVisible(target, duration: const Duration(milliseconds: 1));
      }
    });
    final chapters = orderedChapterNumbers(widget.chapterNumber);
    return Scaffold(
      appBar: AppBar(title: const Text('Arabic Mawlid')),
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
                    color: Colors.white,
                    border: Border.all(color: brightGreen, width: 2),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(asset, fit: BoxFit.contain),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

List<String> chapterPageAssets(int chapter) {
  const pageCounts = [0, 3, 3, 3, 2, 4, 2];
  return [
    for (var page = 1; page <= pageCounts[chapter]; page++)
      'assets/pdf_pages/chapter_$chapter/page_${page.toString().padLeft(2, '0')}.webp',
  ];
}

List<MawlidChapter> orderedChapters(List<MawlidChapter> chapters, int selected) => [
  ...chapters.where((chapter) => chapter.number >= selected),
  ...chapters.where((chapter) => chapter.number < selected),
];

List<int> orderedChapterNumbers(int selected) => [
  for (var chapter = selected; chapter <= 6; chapter++) chapter,
  for (var chapter = 1; chapter < selected; chapter++) chapter,
];

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
      chapterNumber == 6 ? 'CHAPTER 06  ·  DUA' : 'CHAPTER ${chapterNumber.toString().padLeft(2, '0')}  ·  HADEES & BAITH',
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),
    ),
  );
}

class ReaderVerse extends StatelessWidget {
  const ReaderVerse({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(22),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: Colors.black12)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: deepGreen,
        fontFamily: 'NotoSansKannada',
        fontSize: 19,
        height: 1.55,
      ),
    ),
  );
}

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

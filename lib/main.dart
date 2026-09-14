import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import 'audio_player_service.dart';
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
    this.reciter =
        'Sayyid Thaha Tangal Pookkottur / Hafiz Nizamuddeen Mahmoodi',
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
  }) => AppSettings(
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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ManqoosApp());
}

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
    bottomNavigationBar: selectedTab == 1
        ? null
        : NavigationBar(
            selectedIndex: selectedTab,
            onDestinationSelected: (index) => setState(() => selectedTab = index),
            indicatorColor: paleGreen,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), label: 'HOME'),
              NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'MAWLID'),
              NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'SETTINGS'),
            ],
          ),
  );
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <HomeMenuItem>[
      HomeMenuItem(
        icon: Icons.menu_book,
        label: 'Mawlid',
        page: const ChaptersScreen(),
      ),
      HomeMenuItem(
        icon: Icons.grid_view,
        label: 'Q&A',
        page: const AboutScreen(title: 'Q&A'),
      ),
      HomeMenuItem(
        icon: Icons.info_outline,
        label: 'About Mawlid',
        page: const AboutScreen(title: 'About Mawlid'),
      ),
      HomeMenuItem(
        icon: Icons.record_voice_over,
        label: 'Reciter',
        page: const ReciterScreen(),
      ),
      HomeMenuItem(
        icon: Icons.settings,
        label: 'Settings',
        page: const SettingsScreen(),
      ),
      HomeMenuItem(
        icon: Icons.phone_android,
        label: 'About App',
        page: const AboutScreen(title: 'About App'),
      ),
      HomeMenuItem(
        icon: Icons.people,
        label: 'About Us',
        page: const AboutScreen(title: 'About Us'),
      ),
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
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute<void>(builder: (_) => item.page!));
                  } else {
                    SharePlus.instance.share(
                      ShareParams(
                        text: 'Explore Manqoos Mawlid with Islamic Way.',
                      ),
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

class BrandedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BrandedAppBar({super.key, required this.title, this.subtitle, this.action});

  final String title;
  final String? subtitle;
  final Widget? action;

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
            onPressed: () => Navigator.maybePop(context),
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

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BrandedAppBar(title: 'Chapters', subtitle: 'ಅಧ್ಯಾಯಗಳು'),
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
    return ValueListenableBuilder<AppSettings>(
      valueListenable: appSettings,
      builder: (context, settings, _) => Scaffold(
        appBar: const BrandedAppBar(
          title: 'Reciters',
          subtitle: 'ಓದುಗರು / ಪಾಠ ಮಾಡುವವರು',
        ),
        body: PatternBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: paleGreen, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Select your preferred reciter for Mawlid audio playback. Tap the play button to preview.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: mawlidReciters.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 18),
                  itemBuilder: (context, index) {
                    final reciter = mawlidReciters[index];
                    final isSelected = settings.reciter.toLowerCase().contains(
                          reciter.id == 'arif' ? 'arif' : 'thaha',
                        );
                    return ReciterCard(
                      reciter: reciter,
                      isSelected: isSelected,
                      onSelect: () {
                        appSettings.value = settings.copyWith(
                          reciter: reciter.englishName,
                        );
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Selected reciter: ${reciter.englishName.split('/').first.trim()}',
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor: deepGreen,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              AnimatedBuilder(
                animation: mawlidAudio,
                builder: (context, _) {
                  if (mawlidAudio.playerState == PlayerState.stopped) {
                    return const SizedBox.shrink();
                  }
                  final current = mawlidAudio.currentReciter;
                  return Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xff09500a),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: paleGreen.withValues(alpha: 0.6),
                        width: 1.5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (current != null) {
                              mawlidAudio.togglePlayForReciter(current);
                            }
                          },
                          icon: Icon(
                            mawlidAudio.isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            color: Colors.white,
                            size: 34,
                          ),
                        ),
                        IconButton(
                          onPressed: () => mawlidAudio.stop(),
                          icon: const Icon(
                            Icons.stop_circle,
                            color: Colors.white70,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                current?.englishName.split('/').first.trim() ??
                                    'Recitation',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                '${MawlidAudioController.formatTime(mawlidAudio.position)} / ${MawlidAudioController.formatTime(mawlidAudio.duration)}',
                                style: const TextStyle(
                                  color: paleGreen,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReciterCard extends StatelessWidget {
  const ReciterCard({
    super.key,
    required this.reciter,
    required this.isSelected,
    required this.onSelect,
  });

  final ReciterInfo reciter;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: mawlidAudio,
      builder: (context, _) {
        final isPlayingThis = mawlidAudio.isReciterPlaying(reciter.id);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onSelect,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(35),
              right: Radius.circular(20),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              constraints: const BoxConstraints(minHeight: 115),
              padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xff0b5e0c).withValues(alpha: 0.92)
                    : const Color(0xff063d07).withValues(alpha: 0.55),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(35),
                  right: Radius.circular(20),
                ),
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.white30,
                  width: isSelected ? 2.5 : 1.2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      mawlidAudio.togglePlayForReciter(reciter);
                      if (!isSelected) {
                        onSelect();
                      }
                    },
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected ? paleGreen : Colors.white70,
                          width: 2.5,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        isPlayingThis ? Icons.pause : Icons.play_arrow,
                        color: deepGreen,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          reciter.englishName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.85),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          reciter.kannadaName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'NotoSansKannada',
                            color: isSelected ? paleGreen : Colors.white60,
                            fontSize: 12,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: isSelected ? paleGreen : Colors.white38,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isSelected ? 'Selected' : 'Tap to select',
                              style: TextStyle(
                                color: isSelected ? paleGreen : Colors.white54,
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IslamicStarAvatar(
                    imagePath: reciter.imagePath,
                    size: 82,
                    isSelected: isSelected,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

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
      appBar: const BrandedAppBar(title: 'Settings', subtitle: 'ಸೆಟ್ಟಿಂಗ್ಸ್'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 28),
        children: [
          SettingsSection(
            title: 'Translation language',
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Kannada', label: Text('Kannada')),
                ButtonSegment(value: 'English', label: Text('English')),
              ],
              selected: {settings.language},
              onSelectionChanged: (value) =>
                  appSettings.value = settings.copyWith(language: value.first),
            ),
          ),
          SettingsSection(
            title: 'Reading mode',
            child: Column(
              children: [
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show translation'),
                  subtitle: const Text('Off opens the Arabic page reader'),
                  value: settings.translationEnabled,
                  onChanged: (value) => appSettings.value = settings.copyWith(
                    translationEnabled: value,
                  ),
                ),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Mushaf Arabic font'),
                  subtitle: const Text(
                    'Use Noto Naskh Arabic instead of Amiri',
                  ),
                  value: settings.mushafArabic,
                  onChanged: (value) => appSettings.value = settings.copyWith(
                    mushafArabic: value,
                  ),
                ),
              ],
            ),
          ),
          SettingsSection(
            title: 'Reciter',
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: IslamicStarAvatar(
                imagePath: findReciter(settings.reciter).imagePath,
                size: 48,
                isSelected: true,
              ),
              title: Text(
                settings.reciter.split('/').first.trim(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              subtitle: Text(
                findReciter(settings.reciter).kannadaName,
                style: const TextStyle(fontFamily: 'NotoSansKannada', fontSize: 12),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: deepGreen),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const ReciterScreen()),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: brightGreen.withValues(alpha: .35)),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: deepGreen,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    ),
  );
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: BrandedAppBar(title: title),
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
                for (var entryIndex = 0;
                    entryIndex < chapter.entries.length;
                    entryIndex++)
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
        onExplanation: () => _showExplanation(context),
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
    if (content == null || selectedChapterNumber == null || selectedEntryIndex == null) {
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
    final selected = selectedChapterNumber == chapter.number &&
        selectedEntryIndex == entryIndex;
    final translation = settings.language == 'Kannada' && entry.kannada.isNotEmpty
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
                  fontFamily: settings.mushafArabic ? 'NotoNaskhArabic' : 'Amiri',
                  fontSize: 25,
                  color: deepGreen,
                ),
              ),
            ),
            ReaderVerse(text: translation, selected: selected),
          ],
        ),
      ),
    );
  }

  Future<String?> _selectedText() async {
    final content = await _loadContent();
    final entry = _selectedEntry(content);
    if (entry == null) return null;
    final translation = appSettings.value.language == 'Kannada' && entry.kannada.isNotEmpty
        ? entry.kannada
        : entry.english;
    return '${entry.arabic}\n$translation${entry.explanation.isEmpty ? '' : '\n${entry.explanation}'}';
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

  Future<void> _showExplanation(BuildContext context) async {
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
              style: const TextStyle(
                color: deepGreen,
                fontFamily: 'NotoSansKannada',
                fontSize: 17,
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
      ShareParams(
        text: text,
        subject: 'Manqoos Mawlid verse',
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
  const ReaderActionBar({
    super.key,
    required this.showExplanation,
    required this.explanationEnabled,
    required this.reciter,
    required this.onExplanation,
    required this.onCopy,
    required this.onShare,
  });
  final bool showExplanation;
  final bool explanationEnabled;
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
          AnimatedBuilder(
            animation: mawlidAudio,
            builder: (context, _) {
              final isCurrentPlaying = mawlidAudio.isReciterPlaying(reciter);
              final isCurrentActive = mawlidAudio.isReciterActive(reciter);
              final durationText = isCurrentActive && mawlidAudio.duration > Duration.zero
                  ? '${MawlidAudioController.formatTime(mawlidAudio.position)} / ${MawlidAudioController.formatTime(mawlidAudio.duration)}'
                  : null;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isCurrentActive && mawlidAudio.duration.inMilliseconds > 0)
                    LinearProgressIndicator(
                      value: (mawlidAudio.position.inMilliseconds /
                              mawlidAudio.duration.inMilliseconds)
                          .clamp(0.0, 1.0),
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(paleGreen),
                      minHeight: 3,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Row(
                      children: [
                        IconButton(
                          tooltip: isCurrentPlaying ? 'Pause' : 'Play recitation',
                          onPressed: () => mawlidAudio.togglePlayForCurrent(reciter),
                          color: Colors.white,
                          icon: Icon(
                            isCurrentPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            size: 34,
                          ),
                        ),
                        IconButton(
                          tooltip: 'Stop',
                          onPressed: isCurrentActive ? () => mawlidAudio.stop() : null,
                          color: isCurrentActive ? Colors.white : Colors.white38,
                          icon: const Icon(Icons.stop_circle, size: 28),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                reciter,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                durationText ?? 'Tap play to listen',
                                style: const TextStyle(
                                  color: paleGreen,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Row(
            children: [
              _ReaderAction(
                icon: Icons.article,
                label: 'EXPLANATION',
                active: showExplanation,
                enabled: explanationEnabled,
                onPressed: onExplanation,
              ),
              _ReaderAction(icon: Icons.copy, label: 'COPY', onPressed: onCopy),
              _ReaderAction(
                icon: Icons.share,
                label: 'SHARE',
                onPressed: onShare,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _ReaderAction extends StatelessWidget {
  const _ReaderAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.active = false,
    this.enabled = true,
  });
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool active;
  final bool enabled;

  @override
  Widget build(BuildContext context) => Expanded(
    child: SizedBox(
      height: 72,
      child: TextButton(
        onPressed: enabled ? onPressed : null,
        style: TextButton.styleFrom(
          foregroundColor: enabled && active ? paleGreen : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: !enabled
                  ? Colors.white38
                  : active
                  ? paleGreen
                  : Colors.white,
              size: 25,
            ),
            const SizedBox(height: 3),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: TextStyle(
                    color: !enabled
                      ? Colors.white38
                      : active
                      ? paleGreen
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
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

class AudioBar extends StatelessWidget {
  const AudioBar({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<AppSettings>(
    valueListenable: appSettings,
    builder: (context, settings, _) => AnimatedBuilder(
      animation: mawlidAudio,
      builder: (context, _) {
        final reciter = settings.reciter;
        final isPlaying = mawlidAudio.isReciterPlaying(reciter);
        final isActive = mawlidAudio.isReciterActive(reciter);
        final durationText = isActive && mawlidAudio.duration > Duration.zero
            ? '${MawlidAudioController.formatTime(mawlidAudio.position)} / ${MawlidAudioController.formatTime(mawlidAudio.duration)}'
            : null;

        return Material(
          color: brightGreen,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isActive && mawlidAudio.duration.inMilliseconds > 0)
                  LinearProgressIndicator(
                    value: (mawlidAudio.position.inMilliseconds /
                            mawlidAudio.duration.inMilliseconds)
                        .clamp(0.0, 1.0),
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation<Color>(paleGreen),
                    minHeight: 3,
                  ),
                SizedBox(
                  height: 68,
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      IconButton(
                        tooltip: isPlaying ? 'Pause' : 'Play recitation',
                        onPressed: () => mawlidAudio.togglePlayForCurrent(reciter),
                        color: Colors.white,
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          size: 36,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Stop',
                        onPressed: isActive ? () => mawlidAudio.stop() : null,
                        color: isActive ? Colors.white : Colors.white38,
                        icon: const Icon(Icons.stop_circle, size: 30),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reciter,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              durationText ?? 'Tap play to listen',
                              style: const TextStyle(
                                color: paleGreen,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

List<String> chapterPageAssets(int chapter) {
  const pageCounts = [0, 3, 3, 3, 2, 4, 2];
  return [
    for (var page = 1; page <= pageCounts[chapter]; page++)
      'assets/pdf_pages_png/chapter_$chapter/page_${page.toString().padLeft(2, '0')}.png',
  ];
}

List<MawlidChapter> orderedChapters(
  List<MawlidChapter> chapters,
  int selected,
) => [
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

class ReaderVerse extends StatelessWidget {
  const ReaderVerse({super.key, required this.text, this.selected = false});
  final String text;
  final bool selected;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      border: const Border(top: BorderSide(color: Colors.black12)),
      color: selected ? paleGreen.withValues(alpha: .35) : null,
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

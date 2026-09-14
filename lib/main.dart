import 'package:flutter/material.dart';

import 'content.dart';

const deepGreen = Color(0xff087509);
const brightGreen = Color(0xff16820c);
const paleGreen = Color(0xffd7e99d);

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
          ? const ReaderScreen()
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
          label: 'TRANSLATION',
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
    final items = <({IconData icon, String label, Widget page})>[
      (icon: Icons.menu_book, label: 'Mawlid', page: const ChaptersScreen()),
      (
        icon: Icons.grid_view,
        label: 'Q&A',
        page: const AboutScreen(title: 'Q&A'),
      ),
      (
        icon: Icons.info_outline,
        label: 'About Mawlid',
        page: const AboutScreen(title: 'About Mawlid'),
      ),
      (
        icon: Icons.record_voice_over,
        label: 'Reciter',
        page: const ReciterScreen(),
      ),
      (icon: Icons.settings, label: 'Settings', page: const SettingsScreen()),
      (
        icon: Icons.phone_android,
        label: 'About App',
        page: const AboutScreen(title: 'About App'),
      ),
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
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => items[index].page),
                ),
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
                        builder: (_) =>
                            ReaderScreen(chapterNumber: chapter.number),
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
    final names = ['Sayyid Thaha Tangal Pookkottur', 'Arif Sa\'adi Katipalla'];
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
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reciter selected')),
                  ),
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
  String language = 'Kannada';
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Translation language',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          DropdownButton<String>(
            value: language,
            items: const [
              DropdownMenuItem(value: 'Kannada', child: Text('Kannada')),
              DropdownMenuItem(value: 'English', child: Text('English')),
            ],
            onChanged: (value) => setState(() => language = value!),
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
    body: const Padding(
      padding: EdgeInsets.all(28),
      child: Text(
        'Manqoos Mawlid with Kannada and English translation and recitation.',
        style: TextStyle(color: deepGreen, fontSize: 20, height: 1.5),
      ),
    ),
  );
}

class ReaderScreen extends StatelessWidget {
  const ReaderScreen({super.key, this.chapterNumber = 1});

  final int chapterNumber;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Mawlid Translation')),
    body: FutureBuilder<MawlidContent>(
      future: MawlidContent.loadEnglish(),
      builder: (context, snapshot) {
        final content = snapshot.data ?? MawlidContent.fallbackEnglish();
        final chapter = content.chapters.firstWhere(
          (entry) => entry.number == chapterNumber,
          orElse: () => content.chapters.first,
        );

        return ListView(
          children: chapter.entries
              .map(
                (entry) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        entry.arabic,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontSize: 25, color: deepGreen),
                      ),
                    ),
                    ReaderVerse(text: entry.english),
                  ],
                ),
              )
              .toList(),
        );
      },
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
      style: const TextStyle(color: deepGreen, fontSize: 19, height: 1.55),
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

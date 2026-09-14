import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../models/app_settings.dart';
import '../theme/app_theme.dart';
import '../widgets/green_header.dart';
import 'about_screen.dart';
import 'arabic_pdf_screen.dart';
import 'chapters_screen.dart';
import 'reader_screen.dart';
import 'reciter_screen.dart';
import 'settings_screen.dart';

class HomeMenuItem {
  const HomeMenuItem({required this.icon, required this.label, this.page});

  final IconData icon;
  final String label;
  final Widget? page;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: selectedTab == 0,
    onPopInvokedWithResult: (didPop, _) {
      if (!didPop && selectedTab != 0) {
        setState(() => selectedTab = 0);
      }
    },
    child: Scaffold(
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
                      ? ReaderScreen(
                          chapterNumber: chapter,
                          onBack: () => setState(() => selectedTab = 0),
                        )
                      : ArabicPdfScreen(
                          chapterNumber: chapter,
                          onBack: () => setState(() => selectedTab = 0),
                        ),
                ),
              )
            : SettingsScreen(onBack: () => setState(() => selectedTab = 0)),
      ),
      bottomNavigationBar: selectedTab == 1
          ? null
          : NavigationBar(
              selectedIndex: selectedTab,
              onDestinationSelected: (index) =>
                  setState(() => selectedTab = index),
              indicatorColor: paleGreen,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: 'HOME',
                ),
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
    ),
  );
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <HomeMenuItem>[
      const HomeMenuItem(
        icon: Icons.menu_book,
        label: 'Mawlid',
        page: ChaptersScreen(),
      ),
      const HomeMenuItem(
        icon: Icons.grid_view,
        label: 'Q&A',
        page: AboutScreen(title: 'Q&A'),
      ),
      const HomeMenuItem(
        icon: Icons.info_outline,
        label: 'About Mawlid',
        page: AboutScreen(title: 'About Mawlid'),
      ),
      const HomeMenuItem(
        icon: Icons.record_voice_over,
        label: 'Reciter',
        page: ReciterScreen(),
      ),
      const HomeMenuItem(
        icon: Icons.settings,
        label: 'Settings',
        page: SettingsScreen(),
      ),
      const HomeMenuItem(
        icon: Icons.phone_android,
        label: 'About App',
        page: AboutScreen(title: 'About App'),
      ),
      const HomeMenuItem(
        icon: Icons.people,
        label: 'About Us',
        page: AboutScreen(title: 'About Us'),
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
                        text: 'Explore Manqoos Mawlid App by Islamic Way. Download the app now: https://itsallwidgets.com/manqoos-mawlid',
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

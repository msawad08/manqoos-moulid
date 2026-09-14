import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

export 'audio_player_service.dart';
export 'content.dart';
export 'data/about_data.dart';
export 'models/app_settings.dart';
export 'screens/about_screen.dart';
export 'screens/arabic_pdf_screen.dart';
export 'screens/chapters_screen.dart';
export 'screens/home_screen.dart';
export 'screens/reader_screen.dart';
export 'screens/reciter_screen.dart';
export 'screens/settings_screen.dart';
export 'theme/app_theme.dart';
export 'widgets/audio_bar.dart';
export 'widgets/branded_app_bar.dart';
export 'widgets/chapter_divider.dart';
export 'widgets/green_header.dart';
export 'widgets/islamic_star_avatar.dart';
export 'widgets/pattern_body.dart';
export 'widgets/reader_action_bar.dart';

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
    theme: buildAppTheme(),
    home: const HomeScreen(),
  );
}

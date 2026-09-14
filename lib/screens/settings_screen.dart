import 'package:flutter/material.dart';
import '../audio_player_service.dart';
import '../models/app_settings.dart';
import '../theme/app_theme.dart';
import '../widgets/branded_app_bar.dart';
import '../widgets/islamic_star_avatar.dart';
import 'reciter_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<AppSettings>(
    valueListenable: appSettings,
    builder: (context, settings, _) => Scaffold(
      appBar: BrandedAppBar(
        title: 'Settings',
        subtitle: 'ಸೆಟ್ಟಿಂಗ್ಸ್',
        onBack: widget.onBack,
      ),
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
            title: 'Translation font size',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SegmentedButton<FontSizeLevel>(
                  segments: [
                    ButtonSegment(
                      value: FontSizeLevel.small,
                      label: Text(
                        settings.language == 'Kannada' ? 'ಸಣ್ಣ' : 'Small',
                      ),
                    ),
                    ButtonSegment(
                      value: FontSizeLevel.medium,
                      label: Text(
                        settings.language == 'Kannada' ? 'ಮಧ್ಯಮ' : 'Medium',
                      ),
                    ),
                    ButtonSegment(
                      value: FontSizeLevel.large,
                      label: Text(
                        settings.language == 'Kannada' ? 'ದೊಡ್ಡ' : 'Large',
                      ),
                    ),
                  ],
                  selected: {settings.fontSize},
                  onSelectionChanged: (value) => appSettings.value =
                      settings.copyWith(fontSize: value.first),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: paleGreen.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: brightGreen.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preview (${settings.fontSize.label}):',
                        style: const TextStyle(
                          fontSize: 12,
                          color: deepGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        settings.language == 'Kannada'
                            ? 'ಪ್ರವಾದಿ ಮುಹಮ್ಮದ್ (ಸ.ಅ) ಅವರ ಮೇಲಿನ ಪ್ರಶಂಸೆ ಹಾಗೂ ಸ್ಮರಣೆ.'
                            : 'Praise and remembrance of the beloved Prophet Muhammad (pbuh).',
                        style: TextStyle(
                          fontSize: settings.fontSize.translationFontSize,
                          color: Colors.black87,
                          fontFamily: 'NotoSansKannada',
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
    decoration: BoxDecoration(
      border: Border.all(color: brightGreen.withValues(alpha: .35)),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
    ),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
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
      ),
    ),
  );
}

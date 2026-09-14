import 'package:flutter/material.dart';
import '../audio_player_service.dart';
import '../models/app_settings.dart';
import '../theme/app_theme.dart';
import '../widgets/branded_app_bar.dart';
import '../widgets/islamic_star_avatar.dart';
import '../widgets/pattern_body.dart';

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

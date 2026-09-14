import 'package:flutter/material.dart';
import '../audio_player_service.dart';
import '../models/app_settings.dart';
import '../theme/app_theme.dart';

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

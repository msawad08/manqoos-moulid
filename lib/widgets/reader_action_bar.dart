import 'package:flutter/material.dart';
import '../audio_player_service.dart';
import '../theme/app_theme.dart';

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
              ReaderActionButton(
                icon: Icons.article,
                label: 'EXPLANATION',
                active: showExplanation,
                enabled: explanationEnabled,
                onPressed: onExplanation,
              ),
              ReaderActionButton(
                icon: Icons.copy,
                label: 'COPY',
                onPressed: onCopy,
              ),
              ReaderActionButton(
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

class ReaderActionButton extends StatelessWidget {
  const ReaderActionButton({
    super.key,
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

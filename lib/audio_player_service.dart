import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

export 'package:audioplayers/audioplayers.dart';

class ReciterInfo {
  const ReciterInfo({
    required this.id,
    required this.englishName,
    required this.kannadaName,
    required this.imagePath,
    required this.audioAsset,
    this.designation = '',
  });

  final String id;
  final String englishName;
  final String kannadaName;
  final String imagePath;
  final String audioAsset;
  final String designation;
}

const List<ReciterInfo> mawlidReciters = [
  ReciterInfo(
    id: 'thaha',
    englishName: 'Sayyid Thaha Tangal Pookkottur / Hafiz Nizamuddeen Mahmoodi',
    kannadaName: 'ಸಯ್ಯಿದ್ ತಾಹಾ ತಂಙಳ್ ಪೂಕ್ಕೊಟ್ಟೂರ್ / ಹಾಫಿಜ್ ನಿಜಾಮುದ್ದೀನ್ ಮಹ್ಮೂದಿ',
    imagePath: 'assets/images/thaha_tangal.png',
    audioAsset: 'audio/taha_manqus-c.mp3',
    designation: 'Pookkottur / Azhithala',
  ),
  ReciterInfo(
    id: 'arif',
    englishName: "Arif Sa'adi Katipalla",
    kannadaName: 'ಆರಿಫ್ ಸಅದಿ ಕಟಿಪಳ್ಳ',
    imagePath: 'assets/images/arif_sadi.png',
    audioAsset: 'audio/arif-c.mp3',
    designation: 'Katipalla',
  ),
];

ReciterInfo findReciter(String nameOrId) {
  final lower = nameOrId.toLowerCase();
  if (lower.contains('arif')) {
    return mawlidReciters[1];
  }
  return mawlidReciters[0];
}

class MawlidAudioController extends ChangeNotifier {
  static final MawlidAudioController instance = MawlidAudioController._();

  MawlidAudioController._();

  AudioPlayer? _player;
  PlayerState _playerState = PlayerState.stopped;
  String? _currentReciterId;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  PlayerState get playerState => _playerState;
  bool get isPlaying => _playerState == PlayerState.playing;
  bool get isPaused => _playerState == PlayerState.paused;
  String? get currentReciterId => _currentReciterId;
  Duration get position => _position;
  Duration get duration => _duration;

  ReciterInfo? get currentReciter =>
      _currentReciterId != null ? findReciter(_currentReciterId!) : null;

  bool isReciterPlaying(String idOrName) {
    final r = findReciter(idOrName);
    return isPlaying && _currentReciterId == r.id;
  }

  bool isReciterActive(String idOrName) {
    final r = findReciter(idOrName);
    return (isPlaying || isPaused) && _currentReciterId == r.id;
  }

  AudioPlayer get player {
    if (_player == null) {
      final p = AudioPlayer();
      _player = p;
      _setupListeners(p);
    }
    return _player!;
  }

  void _setupListeners(AudioPlayer p) {
    try {
      p.onPlayerStateChanged.listen((state) {
        _playerState = state;
        notifyListeners();
      });
      p.onPositionChanged.listen((pos) {
        _position = pos;
        notifyListeners();
      });
      p.onDurationChanged.listen((dur) {
        _duration = dur;
        notifyListeners();
      });
      p.onPlayerComplete.listen((_) {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
        notifyListeners();
      });
    } catch (e) {
      debugPrint('Audio listener initialization error: $e');
    }
  }

  Future<void> playReciter(ReciterInfo reciter) async {
    try {
      if (_currentReciterId == reciter.id && _playerState == PlayerState.paused) {
        await player.resume();
      } else {
        _currentReciterId = reciter.id;
        await player.stop();
        await player.setReleaseMode(ReleaseMode.stop);
        await player.play(AssetSource(reciter.audioAsset));
      }
    } catch (e) {
      debugPrint('Error in playReciter: $e');
    }
  }

  Future<void> pause() async {
    try {
      await player.pause();
    } catch (e) {
      debugPrint('Error pausing audio: $e');
    }
  }

  Future<void> resume() async {
    try {
      await player.resume();
    } catch (e) {
      debugPrint('Error resuming audio: $e');
    }
  }

  Future<void> stop() async {
    try {
      await player.stop();
      _position = Duration.zero;
      _playerState = PlayerState.stopped;
      notifyListeners();
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
  }

  Future<void> seek(Duration newPosition) async {
    try {
      await player.seek(newPosition);
    } catch (e) {
      debugPrint('Error seeking audio: $e');
    }
  }

  Future<void> togglePlayForReciter(ReciterInfo reciter) async {
    if (isPlaying && _currentReciterId == reciter.id) {
      await pause();
    } else {
      await playReciter(reciter);
    }
  }

  Future<void> togglePlayForCurrent(String selectedReciterName) async {
    final reciter = findReciter(selectedReciterName);
    if (isPlaying) {
      if (_currentReciterId == reciter.id) {
        await pause();
      } else {
        await playReciter(reciter);
      }
    } else if (isPaused && _currentReciterId == reciter.id) {
      await resume();
    } else {
      await playReciter(reciter);
    }
  }

  static String formatTime(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }
}

final mawlidAudio = MawlidAudioController.instance;

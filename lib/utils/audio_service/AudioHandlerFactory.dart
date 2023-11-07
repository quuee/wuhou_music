
import 'package:audio_service/audio_service.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';
import 'package:wuhoumusic/utils/log_util.dart';


class AudioHandlerFactory{

  static final AudioHandlerFactory _instance = AudioHandlerFactory._internal();

  factory AudioHandlerFactory() {
    return _instance;
  }
  AudioHandlerFactory._internal();

  static bool _isInitialized = false;
  static AudioPlayerHandler? audioHandler;

  Future<void> _initialize() async {
    audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandlerImpl(),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'wuhou.music.channel.audio',
        androidNotificationChannelName: 'wuhou music',
        // androidNotificationIcon: 'drawable/ic_stat_music_note',
        androidShowNotificationBadge: true,
        androidStopForegroundOnPause: false,

      ),
    );
  }

  Future<AudioPlayerHandler> getAudioHandler() async {
    LogI('AudioHandlerFactory getAudioHandler', 'AudioHandlerFactory getAudioHandler');
    if (!_isInitialized) {
      await _initialize();
      _isInitialized = true;
    }
    return audioHandler!;
  }
}
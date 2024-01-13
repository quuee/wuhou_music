
import 'package:audio_service/audio_service.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';
import 'package:wuhoumusic/utils/audio_service/MySwitchHandler.dart';
import 'package:wuhoumusic/utils/audio_service/TextPlayerHandlerImpl.dart';
import 'package:wuhoumusic/utils/audio_service/common.dart';
import 'package:wuhoumusic/utils/log_util.dart';

// extension ExtensionSwitchAudioHandler on WHAudioPlayerHandler {
//   Future<void> switchToHandler(int? index) async {
//     if (index == null) return;
//     await AudioHandlerFactory.audioHandler
//         ?.customAction('switchToHandler', <String, dynamic>{'index': index});
//   }
// }

class AudioHandlerFactory{

  static final AudioHandlerFactory _instance = AudioHandlerFactory._internal();

  factory AudioHandlerFactory() {
    return _instance;
  }
  AudioHandlerFactory._internal();

  static bool _isInitialized = false;
  static WHAudioPlayerHandler? audioHandler;


  // Future<void> _initialize() async {
  //   audioHandler = await AudioService.init(
  //     builder: () => AudioPlayerHandlerImpl(),
  //     config: AudioServiceConfig(
  //       androidNotificationChannelId: 'wuhou.music.channel.audio',
  //       androidNotificationChannelName: 'wuhou music',
  //       // androidNotificationIcon: 'drawable/ic_stat_music_note',
  //       androidShowNotificationBadge: true,
  //       androidStopForegroundOnPause: false,
  //
  //     ),
  //   );
  // }

  Future<void> _initialize() async {
    audioHandler = await AudioService.init(
      builder: () => MySwitchHandler([AudioPlayerHandlerImpl(),TextPlayerHandlerImpl()]),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'wuhou.music.channel.audio',
        androidNotificationChannelName: 'wuhou music',
        // androidNotificationIcon: 'drawable/ic_stat_music_note',
        androidShowNotificationBadge: true,
        androidStopForegroundOnPause: false,

      ),
    );
  }

  Future<WHAudioPlayerHandler> getAudioHandler() async {
    LogI('AudioHandlerFactory getAudioHandler', 'AudioHandlerFactory getAudioHandler');
    if (!_isInitialized) {
      await _initialize();
      _isInitialized = true;
    }
    return audioHandler!;
  }
}
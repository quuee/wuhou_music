import 'package:get/get.dart';
import 'package:get_it/get_it.dart';


import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';

class PlayController extends GetxController {



  AudioPlayerHandler? audioHandler;

  @override
  void onInit() {
    audioHandler = GetIt.I.get<AudioPlayerHandler>();
    super.onInit();
  }

  void initAudio() {

  }



}

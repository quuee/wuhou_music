import 'dart:io';

import 'package:get/get.dart';
import 'package:wuhoumusic/model/song_entity.dart';

class PlayController extends GetxController {
  SongEntity? currentSong;
  String currentLyricContent = '';

  fetchLyric() {
    if (currentLyricContent.length > 0) {
      return ;
    }
    if (currentSong == null) {
      return '';
    }
    currentLyricContent = '';
    int lastIndex = currentSong!.data!.lastIndexOf('.');
    String lyricPath = currentSong!.data!.substring(0, lastIndex) + '.lrc';
    File lyricFile = File(lyricPath);
    bool exist = lyricFile.existsSync();
    if (exist) {
      currentLyricContent = lyricFile.readAsStringSync();
    } else {
      // 从服务端获取
    }
  }
}

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



  /// 扫描封面
  // Future<void> fetchArts() async {
  //   String sdkInts = LocalStorage.get('sdkInt');
  //   int sdkInt = int.parse(sdkInts);
  //   if (sdkInt >= 29) {
  //     return;
  //   }
  //
  //   final cursor = await AndroidContentResolver.instance.query(
  //     // MediaStore.Audio.Albums.EXTERNAL_CONTENT_URI
  //     uri: 'content://media/external/audio/albums',
  //     projection: const ['_id', 'album_art'],
  //     selection: 'album_art != 0',
  //     selectionArgs: null,
  //     sortOrder: null,
  //   );
  //   try {
  //     final albumCount =
  //     (await cursor!.batchedGet().getCount().commit()).first as int;
  //     final batch = cursor.batchedGet()
  //       ..getInt(0)
  //       ..getString(1);
  //     final albumsData = await batch.commitRange(0, albumCount);
  //     for (final data in albumsData) {
  //       audioHandler!.albumArtPaths[data.first as int] = data.last as String;
  //     }
  //   } finally {
  //     cursor?.close();
  //   }
  //   update();
  // }


}

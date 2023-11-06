import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wuhoumusic/model/any_entity.dart';
import 'package:wuhoumusic/model/cache_songs_entity.dart';
import 'package:wuhoumusic/model/sl_songs_entity.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/model/songs_list_entity.dart';

class IsarHelper {
  IsarHelper._privateConstructor();
  static final IsarHelper _instance = IsarHelper._privateConstructor();
  static IsarHelper get instance => _instance;

  late final Isar isarInstance;

  init() async {
    final dir = await getApplicationDocumentsDirectory();
    isarInstance = await Isar.open(
      [
        SongEntitySchema,
        SongsListEntitySchema,
        AnyEntitySchema,
        CacheSongEntitySchema,
        SLSongsEntitySchema
      ],
      directory: dir.path,
    );
  }
}

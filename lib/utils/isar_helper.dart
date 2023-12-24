import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wuhoumusic/model/any_entity.dart';
import 'package:wuhoumusic/model/audio/cache_songs_entity.dart';
import 'package:wuhoumusic/model/audio/sl_songs_entity.dart';
import 'package:wuhoumusic/model/audio/song_entity.dart';
import 'package:wuhoumusic/model/audio/songs_list_entity.dart';
import 'package:wuhoumusic/model/book_novel/book_chapter_entity.dart';
import 'package:wuhoumusic/model/book_novel/book_novel_entity.dart';
import 'package:wuhoumusic/model/book_novel/read_config_entity.dart';

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
        SLSongsEntitySchema,
        BookNovelEntitySchema,
        BookChapterEntitySchema,
        ReadConfigEntitySchema
      ],
      directory: dir.path,
    );
  }
}

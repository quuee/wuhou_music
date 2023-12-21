import 'package:get/get.dart';
import 'package:wuhoumusic/views/book_shelf/reader/read_controller.dart';
import 'package:wuhoumusic/views/book_shelf/reader/read_screen.dart';
import 'package:wuhoumusic/views/book_shelf/reader/read_screen_test.dart';
import 'package:wuhoumusic/views/book_shelf/reader/read_test_controller.dart';
import 'package:wuhoumusic/views/login/login_page.dart';
import 'package:wuhoumusic/views/root/root_page.dart';
import 'package:wuhoumusic/views/login/binding.dart';
import 'package:wuhoumusic/views/root/binding.dart';
import 'package:wuhoumusic/views/songs_list/local_music/local_music_controller.dart';
import 'package:wuhoumusic/views/songs_list/local_music/local_music_page.dart';
import 'package:wuhoumusic/views/songs_list/play/play_page.dart';
import 'package:wuhoumusic/views/songs_list/song_list_detail/song_list_add_page.dart';
import 'package:wuhoumusic/views/songs_list/song_list_detail/song_list_detail_controller.dart';
import 'package:wuhoumusic/views/songs_list/song_list_detail/song_list_detail_page.dart';
import 'package:wuhoumusic/views/splash/splash_page.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const root = '/root';
  static const play = '/play';
  static const localMusicPage = '/local_music_page';
  static const songListDetail = '/song_list_detail';
  static const songListAdd = '/song_list_add';

  static const reader = '/reader';
  static const readerTest = '/reader_test';

  static final routes = <GetPage>[
    GetPage(
      name: splash,
      page: () => const SplashPage(),
    ),
    GetPage(
        name: login, page: () => const LoginPage(), binding: LoginBinding()),
    GetPage(name: root, page: () => const RootPage(), binding: RootBinding()),
    GetPage(
      name: play,
      page: () => const PlayPage(),
    ),
    GetPage(
        name: localMusicPage,
        page: () => const LocalMusicPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LocalMusicController());
          Get.lazyPut(() => SongListDetailController());
        })),
    GetPage(
        name: songListDetail,
        page: () => SongListDetailPage(),
        binding: BindingsBuilder(
            () => Get.lazyPut(() => SongListDetailController()))),
    GetPage(
        name: songListAdd,
        page: () => SongListAddPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SongListDetailController());
          Get.lazyPut(() => LocalMusicController());
        })),
    // 阅读页面
    GetPage(name: reader, page: () => ReadScreen(),binding: BindingsBuilder(() {Get.lazyPut(() => ReadController());})),
    GetPage(name: readerTest, page: () => ReadScreenText(),binding: BindingsBuilder(() {Get.lazyPut(() => ReadTestController());}))
  ];
}

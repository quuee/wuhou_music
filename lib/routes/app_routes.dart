import 'package:get/get.dart';
import 'package:wuhoumusic/views/home/home_page.dart';
import 'package:wuhoumusic/views/login/login_page.dart';
import 'package:wuhoumusic/views/mine/mine_page.dart';
import 'package:wuhoumusic/views/mine/ui/local_music_page.dart';
import 'package:wuhoumusic/views/play/play_page.dart';
import 'package:wuhoumusic/views/root/root_page.dart';
import 'package:wuhoumusic/views/login/binding.dart';
import 'package:wuhoumusic/views/root/binding.dart';
import 'package:wuhoumusic/views/splash/splash_page.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const root = '/root';
  static const home = '/home';
  static const mine = '/mine';
  static const play = '/play';
  static const localMusicPage = '/local_music_page';

  static final routes = <GetPage>[
    GetPage(
      name: splash, page: () => const SplashPage(),
    ),
    GetPage(
        name: login, page: () => const LoginPage(), binding: LoginBinding()
    ),
    GetPage(
        name: root, page: () => const RootPage(), binding: RootBinding()
    ),
    GetPage(
      name: home, page: () => const HomePage(),
    ),
    GetPage(
      name: mine, page: () => const MinePage(),
    ),
    GetPage(
      name: play, page: () => const PlayPage(),
    ),
    GetPage(
      name: localMusicPage, page: () => const LocalMusicPage(),
    ),
  ];
}

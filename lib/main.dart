
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/theme/app_theme.dart';
import 'package:wuhoumusic/utils/audio_service/AudioHandlerFactory.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';
import 'package:wuhoumusic/utils/config.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  // int sdkInt = androidInfo.version.sdkInt;

  // 初始化 Hive
  // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
  //   // await Hive.initFlutter('wuhou_music/Database');
  // } else if (Platform.isIOS) {
  //   // await Hive.initFlutter('Database');
  // } else {
  //   var directory = await getApplicationDocumentsDirectory();
  //   Hive.init(directory.path);
  // }
  // Hive.registerAdapter(SongEntityAdapter());
  // Hive.registerAdapter(SongsListEntityAdapter());
  // for (final box in hiveBoxes) {
  //   await openHiveBox(
  //     box['name'].toString(),
  //     limit: box['limit'] as bool? ?? false,
  //   );
  // }
  // Hive.box(Keys.hiveGlobalParam).put(Keys.sdkInt, sdkInt);

  IsarHelper.instance.init();
  Config.instance.init();
  // 初始化 audio_service
  await initServices();

  runApp(const MyApp());
  topInit();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final child = GetMaterialApp(
      title: 'Wuhou music',
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      themeMode: ThemeMode.system,
      initialRoute: Routes.splash,
      getPages: Routes.routes,
    );

    return child;
  }
}

Future<void> initServices() async {
  final audioHandlerFactory = AudioHandlerFactory();
  final AudioPlayerHandler audioHandler = await audioHandlerFactory.getAudioHandler();
  GetIt.I.registerSingleton<AudioPlayerHandler>(audioHandler);
}

// Future<void> openHiveBox(String boxName, {bool limit = false}) async {
//   final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
//     final Directory dir = await getApplicationDocumentsDirectory();
//     final String dirPath = dir.path;
//     File dbFile = File('$dirPath/$boxName.hive');
//     File lockFile = File('$dirPath/$boxName.lock');
//     if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
//       dbFile = File('$dirPath/wuhou_music/$boxName.hive');
//       lockFile = File('$dirPath/wuhou_music/$boxName.lock');
//     }
//     await dbFile.delete();
//     await lockFile.delete();
//     await Hive.openBox(boxName);
//     throw 'Failed to open $boxName Box\nError: $error';
//   });
//   // clear box if it grows large
//   if (limit && box.length > 500) {
//     box.clear();
//   }
// }

///透明状态栏
topInit() {
  SystemUiOverlayStyle style = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  );
  SystemChrome.setSystemUIOverlayStyle(style);
}

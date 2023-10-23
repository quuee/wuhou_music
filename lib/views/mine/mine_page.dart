import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:images_picker/images_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/common_widgets/song_list.dart';
import 'package:wuhoumusic/model/song_list_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  static final audioPlayHandler = GetIt.I.get<AudioPlayerHandler>();

  List<SongListEntity>? songList;

  String? imagePath;

  late TextEditingController _textEditingController;

  _loadSongList() {
    var box = Hive.box('songList');
    // todo 从hive获取本地歌单
    var temp = box.get('localSongList', defaultValue: <SongListEntity>[]);
    songList = songListFromJson(jsonEncode(temp));
    if (songList == null || songList!.isEmpty) {
      // 从服务端加载
    }
  }

  @override
  initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _loadSongList();
  }

  /// 创建歌单的中间弹窗
  _createSongListInput(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('请输入歌单名称'),
            content: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _textEditingController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      List<Media>? res = await ImagesPicker.pick(
                          count: 1,
                          pickType: PickType.image,
                          language: Language.System);
                      res?.forEach((element) {
                        developer.log(element.toString(), name: 'ImagesPicker');
                      });
                      imagePath = res![0].path;
                    },
                    child: Icon(Icons.add_photo_alternate_outlined),
                  ),
                  // TODO 选择完 不能立即显示  如何更新ui
                  imagePath != null
                      ? Image.file(
                          File(imagePath!),
                          width: 40,
                          height: 40,
                        )
                      : Container(),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                child: Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('确认'),
                onPressed: () {
                  var box = Hive.box(Keys.hiveSongList);
                  var s = SongListEntity(
                      id: Uuid().v1(),
                      songList: _textEditingController.value.text,
                      songListAlbum: imagePath ?? '',
                      count: 0);
                  songList!.add(s);
                  box.put(Keys.localSongList, songList);
                  Navigator.of(context).pop();
                  _textEditingController.clear();
                  imagePath = null;
                  setState(() {});
                },
              ),
            ],
          );
        });
  }

  /// 创建顶部四个功能按钮
  Widget _buildIconButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.scanner),
              onPressed: () {
                Get.toNamed(Routes.localMusicPage);
              },
            ),
            const Text('本地歌曲')
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.add_chart),
              onPressed: () {
                _createSongListInput(context);
              },
            ),
            Text('创建歌单')
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
            Text('待定')
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
            Text('待定')
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
            color: Colors.deepPurple[100],
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(width: 0.5, color: Colors.white70),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: _buildIconButton())),
                Expanded(
                    flex: 6,
                    child: ListView.builder(
                        itemCount: songList!.length,
                        itemBuilder: (context, index) {
                          return SongList(
                            id: songList![index].id,
                            songList: songList![index].songList,
                            count: songList![index].count,
                            songListAlbum: songList![index].songListAlbum,
                          );
                        })),
              ],
            ),
          ),
          Positioned(
              bottom: 0.5,
              child: SizedBox(
                /// Positioned不能自适应宽度
                width: MediaQuery.of(context).size.width,
                child: PlayBar(
                  audioPlayerHandler: audioPlayHandler,
                ),
              ))
        ],
      ),
    ));
  }
}

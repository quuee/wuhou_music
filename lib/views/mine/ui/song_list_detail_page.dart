import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/song_item.dart';
import 'dart:developer' as developer;

class SongListDetailPage extends StatefulWidget {
  const SongListDetailPage({super.key});

  @override
  State<SongListDetailPage> createState() => _SongListDetailPageState();
}

class _SongListDetailPageState extends State<SongListDetailPage> {

  bottomSheet() {
    Get.bottomSheet(
        Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.ring_volume),
                title: Text('设为铃声'),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.add_card_outlined),
                title: Text('添加到歌单'),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('从歌单删除'),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.delete_forever),
                title: Text('本地删除'),
                onTap: null,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white, // bottomsheet背景色
        barrierColor: Colors.white60 // 后面挡住的颜色
    );
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> param = Get.arguments as Map<String, dynamic>;
    developer.log('${Get.parameters}', name: 'SongListDetailPage');
    String songTitle = Get.parameters['title'] ?? '未知';

    return Scaffold(
        appBar: AppBar(
          title: Text('歌单'),
        ),
        // bottomNavigationBar: PlayBar(),
        body: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {},
                  child: Container(
                    child: buildSongItem(
                        index: index,
                        songTitle: 'item' + index.toString(),
                        quality: '超清母带',
                        singer: '阿悄',
                        album: '人来人往',
                    moreFunction: bottomSheet),
                  ));
            }));
  }
}

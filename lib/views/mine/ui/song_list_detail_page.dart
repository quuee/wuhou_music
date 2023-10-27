import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

import 'package:wuhoumusic/common_widgets/song_item.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/views/mine/ui/song_list_detail_controller.dart';

class SongListDetailPage extends GetView<SongListDetailController> {
  SongListDetailPage({super.key});

  _bottomSheet() {
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
      body: GetBuilder<SongListDetailController>(builder: (c) {
        if (c.loadingStatus == LoadingStatus.loading) {
          return Center(
            child: Text('加载中。。。'),
          );
        }
        if (c.loadingStatus == LoadingStatus.success) {
          if(c.songList.isEmpty) return Center(child: Text('空空如也'),);
          return ListView.builder(
              itemCount: c.songList.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {},
                    child: Container(
                      child: SongItem(
                        index: index,
                        songEntity: controller.songList[index],
                      ),
                    ));
              });
        }
        return SizedBox.shrink();
      }),
    );
  }
}

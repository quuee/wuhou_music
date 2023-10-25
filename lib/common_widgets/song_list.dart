import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/model/song_list_entity.dart';
import 'package:wuhoumusic/resource/ali_icons.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/views/mine/mine_controller.dart';

class SongList extends StatelessWidget {
  SongList({
    super.key,
    required this.id,
    required this.listTitle,
    this.listAlbum,
    required this.count,
  });

  String id;
  String listTitle;
  String? listAlbum;
  int count;

  /// 底部弹窗
  _showModalBottomSheet() {
    // showModalBottomSheet(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: <Widget>[
    //           ListTile(
    //             leading: Icon(
    //                 Icons.edit),
    //             title: Text("编辑"),
    //             onTap: () async {
    //
    //             },
    //           ),
    //           ListTile(
    //             leading: Icon(
    //                 Icons.delete),
    //             title: Text("删除"),
    //             onTap: () async {
    //
    //               deleteSongList!();
    //
    //               Get.back();
    //             },
    //           ),
    //         ],
    //       );
    //     });

    Get.bottomSheet(
        Container(
          height: 150,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("编辑"),
                onTap: () async {
                  MineController c = Get.find<MineController>();
                  SongListEntity s = SongListEntity(
                    id: id,
                    listTitle: listTitle,
                    listAlbum: listAlbum!,
                    count: count,
                  );
                  c.addOrUpdateSongListDialog(s);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("删除"),
                onTap: () async {
                  MineController c = Get.find<MineController>();
                  c.deleteSongList(id);
                  Get.back();
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white70);
  }

  @override
  Widget build(BuildContext context) {
    final child = GestureDetector(
      onTap: () {
        Get.toNamed(Routes.songListDetail, parameters: {'title': listTitle});
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            color: Colors.white60, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: Row(
          children: [
            Image.file(
              File(listAlbum!),
              width: 100,
              height: 100,
              fit: BoxFit.none,
              errorBuilder: (BuildContext context, Object error,
                  StackTrace? stackTrace) {
                return Image.asset(
                  R.images.logo,
                  width: 100,
                  height: 100,
                  fit: BoxFit.none,
                );
              },
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(listTitle),
                Text('共$count首'),
              ],
            ),
            Spacer(),
            // PopupMenuButton(itemBuilder: (context){
            //   return [PopupMenuItem(child: Text('menu1'),value: 'menu1',)];
            // })
            IconButton(
                onPressed: () {
                  _showModalBottomSheet();
                },
                icon: Icon(AliIcons.more))
          ],
        ),
      ),
    );
    return child;
  }
}

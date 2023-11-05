import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/model/songs_list_entity.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/views/songs_list/songs_list_controller.dart';

class SongList extends StatelessWidget {
  const SongList({
    super.key,
    required this.id,
    required this.listTitle,
    this.listAlbum,
    required this.count,
  });

  final String id;
  final String listTitle;
  final String? listAlbum;
  final int count;

  /// 底部弹窗
  _showModalBottomSheet() {
    Get.bottomSheet(
        Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("编辑"),
                onTap: () async {
                  SongsListController c = Get.find<SongsListController>();
                  SongsListEntity s = SongsListEntity(
                    id: id,
                    listTitle: listTitle,
                    listAlbum: listAlbum!,
                    count: count,
                  );
                  c.createOrUpdateSongListDialog(s);
                },
              ),
              ListTile(
                leading: Icon(Icons.sync),
                title: Text('同步歌单到云'),
                onTap: () async {
                  SongsListEntity s = SongsListEntity(
                    id: id,
                    listTitle: listTitle,
                    listAlbum: listAlbum!,
                    count: count,
                  );
                  // TODO 提示同步完成
                  SongsListController c = Get.find<SongsListController>();
                  c.syncSongsList(s);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("删除"),
                onTap: () async {
                  SongsListController c = Get.find<SongsListController>();
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
        Get.toNamed(Routes.songListDetail,
            parameters: {'title': listTitle, 'songListUUID': id,'coverImage':listAlbum??''});
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            color: Colors.white60, borderRadius: BorderRadius.circular(10)),
        // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.file(
                File(listAlbum!),
                width: 100,
                height: 100,
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    R.images.logo,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  );
                },
              ),
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
                icon: Icon(Icons.more_vert))
          ],
        ),
      ),
    );
    return child;
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/model/songs_list_entity.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/views/songs_list/songs_list_controller.dart';

class SongList extends StatelessWidget {
  SongList({
    super.key,
    required this.apslid,
    required this.slid,
    required this.listTitle,
    this.listAlbum,
    required this.count,
  });

  final int apslid;
  final String slid;
  final String listTitle;
  String? listAlbum;
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
                    apslid: apslid,
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
                    apslid: apslid,
                    listTitle: listTitle,
                    listAlbum: listAlbum!,
                    count: count,
                  );

                  SongsListController c = Get.find<SongsListController>();
                  c.syncSongsList(s);
                  Fluttertoast.showToast(msg: '同步完成');
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("删除"),
                onTap: () async {
                  SongsListController c = Get.find<SongsListController>();
                  c.deleteSongList(apslid);
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
            parameters: {'title': listTitle, 'songListId': apslid.toString(),'slid':slid!,'coverImage':listAlbum??''});
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

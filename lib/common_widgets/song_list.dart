import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wuhoumusic/model/song_list_entity.dart';
import 'package:wuhoumusic/resource/ali_icons.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/resource/r.dart';

class SongList extends StatelessWidget {

  SongList({super.key,required this.id,required this.songList,this.songListAlbum,required this.count});

  String id;
  String songList;
  String? songListAlbum;
  int count;

  /// 底部弹窗
  _showModalBottomSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                    Icons.edit),
                title: Text("编辑"),
                onTap: () async {

                  var box = Hive.box(Keys.hiveSongList);
                  var temp = box.get(Keys.localSongList);
                  List<SongListEntity> songList = songListFromJson(jsonEncode(temp));
                  songList.removeWhere((element) => element.id == id);
                  box.put(Keys.localSongList, songList);
                },
              ),
              ListTile(
                leading: Icon(
                    Icons.delete),
                title: Text("删除"),
                onTap: () async {},
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(
          vertical: 0, horizontal: 8),
      child: Row(
        children: [
          Image.file(
            File(songListAlbum!),
            width: 100,
            height: 100,
            errorBuilder: (BuildContext context,Object error,StackTrace? stackTrace){return Image.asset(R.images.logo,width: 100,height: 100,);},
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(songList),
              Text('共$count首'),
            ],
          ),
          Spacer(),
          // PopupMenuButton(itemBuilder: (context){
          //   return [PopupMenuItem(child: Text('menu1'),value: 'menu1',)];
          // })
          IconButton(
              onPressed: () {
                _showModalBottomSheet(context);
              },
              icon: Icon(AliIcons.more))
        ],
      ),
    );
  }
}

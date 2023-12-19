import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wuhoumusic/resource/r.dart';

class SongListCover extends StatelessWidget {
  SongListCover(
      {super.key,
      required this.songsListId,
      required this.songsListTitle,
      this.songsListCoverImagePath});
  int songsListId;
  String songsListTitle;
  String? songsListCoverImagePath;
  //封面 歌单名 创建者 共N首，被听N次 可被隐藏

  _buildCover() {
    final coverChild;
    if (songsListCoverImagePath != null &&
        songsListCoverImagePath?.trim().compareTo('') != 0) {
      coverChild = Image.file(
        File(songsListCoverImagePath!),
        width: 100,
        height: 100,
        errorBuilder: (c, e, s) {
          return Image.asset(
            R.images.logo,
            width: 100,
            height: 100,
          );
        },
      );
    } else {
      coverChild = Image.asset(
        R.images.logo,
        width: 100,
        height: 100,
      );
    }
    return coverChild;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 封面
          _buildCover(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                songsListTitle,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
              Text('来自：xxx'),
              Text('共N首'),
              Text('听过N次')
            ],
          )
        ],
      ),
    );
  }
}

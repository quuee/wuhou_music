import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildSongItem(
    {required int index,
    required String songTitle,
    String? quality,
    String? singer,
    String? album,
    VoidCallback? moreFunction}) {
  double songTitleSize = 22;
  double secondSize = 11;

  final content = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        songTitle,
        style: TextStyle(fontSize: songTitleSize),
        overflow: TextOverflow.visible,
        maxLines: 1,
      ), //歌名
      // 歌名组件下面一行
      Row(
        children: [
          Container(
            child: quality != null? Text(
                    quality,
                    style: TextStyle(color: Colors.amber, fontSize: secondSize),
                  )
                : SizedBox.shrink(), //超清母带、黑椒唱片、沉浸声
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amber, width: 0.4),
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Icon(
              Icons.download_done,
              size: 10,
            ), //本地 或 云端(未下载),
          ),
          Text(
            (singer ?? '') + ' - ' + (album ?? ''),
            style: TextStyle(fontSize: secondSize),
            overflow: TextOverflow.visible,
            maxLines: 1,
          ), //歌手 专辑
        ],
      )
    ],
  );

  final widget = Row(
    children: [
      Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              index.toString(),
              style: TextStyle(fontSize: songTitleSize, color: Colors.black45),
            ),
          )),
      Expanded(flex: 7, child: content),
      Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey,
            ),
            onPressed: () {
              if(moreFunction!=null){
                moreFunction();
              }

            },
          ))

      // IconButton(onPressed: click1, icon: Icon(Icons.more_vert))
    ],
  );

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: widget,
  );
}



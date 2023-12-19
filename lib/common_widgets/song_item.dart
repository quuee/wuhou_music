import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/model/audio/song_entity.dart';
import 'package:wuhoumusic/views/songs_list/song_list_detail/song_list_detail_controller.dart';
import 'package:wuhoumusic/views/songs_list/songs_list_controller.dart';

class SongItem extends StatelessWidget {
  SongItem(
      {super.key,
      required this.index,
      required this.songEntity,
      this.fileExist = true});

  final int index;
  final SongEntity songEntity;
  final bool fileExist;
  // final String? quality;
  // final String? singer;
  // final String? album;

  final SongsListController songsListController =
      Get.find<SongsListController>();

  /// 本地音乐底部弹窗
  _bottomSheet() {
    Get.bottomSheet(
        Container(
          // 加点样式
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
                onTap: () {
                  Get.back();

                  _collectBottomSheet();
                },
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

  /// 收藏到歌单
  _collectBottomSheet() {
    List<Widget> list = songsListController.songsList
        .map((e) => ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text(e.listTitle),
              onTap: () {
                SongListDetailController songListDetailController =
                    Get.find<SongListDetailController>();
                songListDetailController
                    .addSongToSongList(e.apslid!, [songEntity]);
                Get.back();
              },
            ))
        .toList();
    list.insert(
        0,
        ListTile(
          leading: Icon(Icons.add),
          title: Text('新建歌单'),
        ));
    Get.bottomSheet(
        Container(
          child: Wrap(
            children: list,
          ),
        ),
        backgroundColor: Colors.white, // bottomsheet背景色
        barrierColor: Colors.white60 // 后面挡住的颜色
        );
  }

  @override
  Widget build(BuildContext context) {
    double songTitleSize = 22;
    double secondSize = 11;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          songEntity.title,
          style: fileExist
              ? TextStyle(
                  fontSize: songTitleSize,
                )
              : TextStyle(fontSize: songTitleSize, color: Colors.grey),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        //歌名
        // 歌名组件下面一行
        Row(
          children: [
            Container(
              child: songEntity.quality != null
                  ? Text(
                      songEntity.quality!,
                      style:
                          TextStyle(color: Colors.amber, fontSize: secondSize),
                    )
                  : SizedBox.shrink(), //超清母带、黑椒唱片、沉浸声
              decoration: BoxDecoration(
                border: Border.all(color: Colors.amber, width: 0.4),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            fileExist
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.download_done,
                      size: 10,
                    ), //本地 或 云端(未下载),
                  )
                : SizedBox.shrink(),
            Expanded(
              child: Text(
                (songEntity.artist) + ' - ' + (songEntity.album ?? ''),
                style: fileExist
                    ? TextStyle(
                        fontSize: secondSize,
                      )
                    : TextStyle(fontSize: secondSize, color: Colors.grey),
                overflow:
                    TextOverflow.ellipsis, // row 里面多个text 需要放在Expanded 才有效
                maxLines: 1,
              ),
            )
            //歌手 专辑
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
                style: TextStyle(fontSize: songTitleSize),
              ),
            )),
        // Expanded(
        //     flex: 2,
        //     child: QueryArtworkWidget(
        //       id: int.parse(songEntity.id),
        //       type: ArtworkType.ALBUM,
        //       keepOldArtwork: true,
        //       artworkBorder: BorderRadius.circular(7.0),
        //       nullArtworkWidget: ClipRRect(
        //         borderRadius: BorderRadius.circular(7.0),
        //         child: Image(
        //           fit: BoxFit.cover,
        //           height: 50.0,
        //           width: 50.0,
        //           image: AssetImage(R.images.logo),
        //         ),
        //       ),
        //     )
        // ),
        Expanded(flex: 7, child: content),
        Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              onPressed: () {
                _bottomSheet();
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/views/local_music/local_music_controller.dart';
import 'package:wuhoumusic/views/song_list_detail/song_list_detail_controller.dart';

class SongListAddPage extends StatefulWidget {
  const SongListAddPage({super.key});

  @override
  State<SongListAddPage> createState() => _SongListAddPageState();
}

class _SongListAddPageState extends State<SongListAddPage> {

  final List<SongEntity> _selectedItems = [];

  @override
  Widget build(BuildContext context) {

    SongListDetailController songListDetailController =
        Get.find<SongListDetailController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('添加音乐到歌单'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        decoration: //装饰
                            InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: '搜索歌曲',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                )),
          ),
          // search bar

          Expanded(
              flex: 17,
              child: GetBuilder<LocalMusicController>(
                builder: (c) {
                  return ListView.builder(
                      itemCount: c.songs.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          value: _selectedItems.contains(c.songs[index]),
                          onChanged: (isChecked) {
                            if (isChecked!) {
                              setState(() {
                                _selectedItems.add(c.songs[index]);
                              });
                            } else {
                              setState(() {
                                _selectedItems.remove(c.songs[index]);
                              });
                            }
                          },
                          // activeColor: ,
                          title: Text(c.songs[index].title),
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      });
                },
              )),
          // songs
        ],
      ),

      // 多选选完后 一键加入歌单
      bottomNavigationBar: ElevatedButton(
        child: Text('加入歌单'),
        onPressed: () {
          songListDetailController.addSongToSongList(null,_selectedItems);
          Get.back();
        },
      ),
    );
  }
}

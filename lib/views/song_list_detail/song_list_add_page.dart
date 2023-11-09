import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/views/song_list_detail/song_list_detail_controller.dart';

class SongListAddPage extends StatefulWidget {
  const SongListAddPage({super.key});

  @override
  State<SongListAddPage> createState() => _SongListAddPageState();
}

class _SongListAddPageState extends State<SongListAddPage> {
  final List<SongEntity> _selectedItems = [];
  //从歌单页面进入 添加歌曲页面，SongListDetailController还在，因为没有退出歌单详情页。
  SongListDetailController songListDetailController =
      Get.find<SongListDetailController>();

  late TextEditingController _searchTextContro;

  String? _searchWord;
  List<SongEntity>? songs;
  @override
  void initState() {
    super.initState();
    _searchTextContro = TextEditingController();
    songs = IsarHelper.instance.isarInstance.songEntitys.where().findAllSync();
  }

  _searchSongs(String keyWord) {
    LogD('SongListAddPage', keyWord);
    setState(() {
      _searchWord = keyWord;
    });
  }

  _buildSearchBar() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          // color: Colors.grey[200],
          border: Border.all(),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search),
            Expanded(
              flex: 1,
              child: TextField(
                controller: _searchTextContro,
                textInputAction: TextInputAction.search,
                decoration: //装饰
                    InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,//特殊属性isDense,作用是在较小空间时，使组件正常渲染（包括文本垂直居中）
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      fillColor: Colors.transparent,
                  hintText: '搜索当前歌曲',
                  hintStyle: TextStyle(fontSize: 14,),
                ),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                onSubmitted: _searchSongs,
              ),
            )
          ],
        ));
  }

  _buildSongs(List<SongEntity>? songs) {
    List<SongEntity> filterSongs = songs ??= [];
    if (_searchWord != null) {
      filterSongs = songs
          .where((element) =>
              element.title.toLowerCase().contains(_searchWord!.toLowerCase()) ||
              element.artist.toLowerCase().contains(_searchWord!.toLowerCase()))
          .toList();
    }
    return ListView.builder(
        itemCount: filterSongs.length,
        itemBuilder: (context, index) {
          // 根据媒体库id判断是否是同一首歌
          int index2 = songListDetailController.songs
              .indexWhere((e) => e.id == filterSongs[index].id);
          return CheckboxListTile(
            value: _selectedItems.contains(filterSongs[index]),
            onChanged: (isChecked) {
              if (isChecked!) {
                setState(() {
                  _selectedItems.add(filterSongs[index]);
                });
              } else {
                setState(() {
                  _selectedItems.remove(filterSongs[index]);
                });
              }
            },
            // activeColor: ,
            title: Text(filterSongs[index].title),
            subtitle: Text(filterSongs[index].artist +
                ' - ' +
                (filterSongs[index].album ?? '')),
            controlAffinity: ListTileControlAffinity.leading,
            enabled: !(index2 >= 0),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('添加音乐到歌单'),
      ),
      body: Column(
        children: [
          // search bar
          Expanded(flex: 1, child: _buildSearchBar()),
          Expanded(flex: 17, child: _buildSongs(songs)),
          // songs
        ],
      ),

      // 多选选完后 一键加入歌单
      bottomNavigationBar: ElevatedButton(
        child: Text('加入歌单'),
        onPressed: () {
          songListDetailController.addSongToSongList(
              songListDetailController.apslid, _selectedItems);
          Get.back();
        },
      ),
    );
  }
}

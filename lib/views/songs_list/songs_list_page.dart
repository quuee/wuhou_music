import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/views/songs_list/ui/songs_list.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/views/songs_list/songs_list_controller.dart';

class SongsListPage extends StatefulWidget {
  const SongsListPage({super.key});

  @override
  State<SongsListPage> createState() => _MinePageState();
}

class _MinePageState extends State<SongsListPage> {
  late SongsListController songsListController;

  @override
  void initState() {
    songsListController = Get.find<SongsListController>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 创建顶部四个功能按钮
  Widget _buildIconButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.localMusicPage);
          },
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.scanner), const Text('本地歌曲')],
          ),
        ),
        GestureDetector(
          onTap: () {
            songsListController.createOrUpdateSongListDialog(null);
          },
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_chart),
              Text('创建歌单'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.ttsTest);
          },
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              Text('测试tts'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              Text('待定'),
            ],
          ),
        ),
      ],
    );
  }

  /// 歌单列表
  Widget _buildSongListWidget() {
    return GetBuilder<SongsListController>(
        // id: SongsListController.songListBuilder,
        builder: (c) {
          if (c.loadingStatus == LoadingStatus.loading) {
            return Center(
              child: Text('加载中。。。'),
            );
          }
          if (c.loadingStatus == LoadingStatus.success) {
            if(c.songsList.isEmpty){
              return SizedBox.shrink();
            }
            return EasyRefresh(
              header: ClassicHeader(),
              footer: ClassicFooter(),
              onRefresh: () => c.pullDownRefresh(),
              onLoad: () => c.pullUponLoading(),
              child: ListView.builder(
                  itemCount: c.songsList.length,
                  itemBuilder: (context, index) {
                    return SongList(
                      apslid: c.songsList[index].apslid ?? -1,
                      slid: c.songsList[index].slid ?? '',
                      listTitle: c.songsList[index].listTitle,
                      count: c.songsList[index].count ?? 0,
                      listAlbum: c.songsList[index].listAlbum ?? '',
                    );
                  }),
            );
          }
          return SizedBox.shrink();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                child: Column(
                  children: [
                    /// 功能按钮
                    Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.white70,
                              border:
                                  Border.all(width: 0.5, color: Colors.white70),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: _buildIconButton())),

                    /// 歌单
                    Expanded(
                      flex: 6,
                      child: _buildSongListWidget(),
                    ),

                    /// 播放栏
                    // Expanded(
                    //   flex: 1,
                    //   child: SizedBox(
                    //     /// Positioned不能自适应宽度
                    //     width: MediaQuery.of(context).size.width,
                    //     child: PlayBar(),
                    //   ),
                    // ),
                  ],
                ),
              ),

              /// 浮动的播放栏
              Positioned(
                  bottom: 0.5,
                  child: SizedBox(
                    /// Positioned不能自适应宽度
                    width: MediaQuery.of(context).size.width,
                    child: PlayBar(),
                  ))
            ],
          ),
        ));
  }
}

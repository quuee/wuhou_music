import 'dart:io';
import 'dart:ui';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_model_builder.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/resource/r.dart';

class Lyric extends StatefulWidget {
  const Lyric({super.key, required this.song});

  final SongEntity song;

  @override
  State<Lyric> createState() => _LyricState();
}

class _LyricState extends State<Lyric> {

  var lyricUI = UINetease();

  var lyricModel;

  List<Widget> buildReaderBackground() {
    return [
      Positioned.fill(
        child: Image.asset(
          R.images.bg1,
          fit: BoxFit.cover,
        ),
      ),
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
      )
    ];
  }

  fetchLyric(String path) {

    if (path.compareTo('') == 0) {
      return '';
    }
    String currentLyricContent = '';
    int lastIndex = path.lastIndexOf('.');
    String lyricPath = path.substring(0, lastIndex) + '.lrc';
    File lyricFile = File(lyricPath);
    bool exist = lyricFile.existsSync();
    if (exist) {
      currentLyricContent = lyricFile.readAsStringSync();
    } else {
      // 从服务端获取
    }

    lyricModel = LyricsModelBuilder.create()
        .bindLyricToMain(currentLyricContent)
        .getModel();
  }

  Widget buildLyricReader() {
    fetchLyric(widget.song.data??"");
    return StreamBuilder<Duration>(
      stream: AudioService.position,
      builder: (content, snapshot) {
        final position = snapshot.data ?? Duration.zero;

        return LyricsReader(
          padding: EdgeInsets.symmetric(horizontal: 40),
          model: lyricModel,
          position: position.inMilliseconds,
          lyricUi: lyricUI,
          playing: true,
          size: Size(double.infinity, MediaQuery.of(context).size.height),
          emptyBuilder: () => Center(
            child: Text(
              'No lyrics',
              style: lyricUI.getOtherMainTextStyle(),
            ),
          ),
          // selectLineBuilder: (progress,confirm){
          //   return Row(
          //     children: [
          //       IconButton(
          //           onPressed: () {
          //             LyricsLog.logD("点击事件");
          //             confirm.call();
          //             // setState(() {
          //             //   audioPlayer?.seek(Duration(milliseconds: progress));
          //             // });
          //           },
          //           icon: Icon(Icons.play_arrow, color: Colors.green)),
          //       Expanded(child: Container(decoration: BoxDecoration(color: Colors.green),height: 1,width: double.infinity,)),
          //       Text(progress.toString(),style: TextStyle(color: Colors.green),)
          //     ],
          //   );
          // },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...buildReaderBackground(),
        buildLyricReader(),
      ],
    );
  }
}

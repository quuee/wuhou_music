import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_model_builder.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';
import 'package:wuhoumusic/views/play/play_controller.dart';

class Lyric extends StatefulWidget {
  const Lyric({super.key});

  @override
  State<Lyric> createState() => _LyricState();
}

class _LyricState extends State<Lyric> {
  double sliderProgress = 111658;
  int playProgress = 111658;
  double max_value = 211658;
  var lyricUI = UINetease();

  static final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();

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

  Widget buildLyricReader() {
    PlayController playController = Get.find<PlayController>();
    playController.fetchLyric();
    var lyricModel = LyricsModelBuilder.create()
        .bindLyricToMain(playController.currentLyricContent)
        .getModel();
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
          size: Size(double.infinity, MediaQuery.of(context).size.height / 2),
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

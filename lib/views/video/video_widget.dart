import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wuhoumusic/model/video/video_entity.dart';
import 'package:wuhoumusic/utils/log_util.dart';

class VideoWidget extends StatefulWidget {
  VideoWidget({super.key, required this.contentHeight, required this.video});

  // bool showFocusButton;
  double contentHeight;
  // Function onClickHeader;
  VideoEntity video;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _videoPlayerController;

  bool _playing = false;

  @override
  void initState() {
    super.initState();
    //assets file networkUrl
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl));

    _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(() {
      setState(() {
        _playing = _videoPlayerController.value.isPlaying;
      });
    });
    _playOrPause();

    // Application.eventBus.on<StopPlayEvent>().listen((event) {
    //   _videoPlayerController.pause();
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  void _playOrPause() {
    _playing = !_playing;
    if (_playing) {
      _videoPlayerController.play();
    } else {
      _videoPlayerController.pause();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1;
    double videoLayoutWidth = MediaQuery.of(context).size.width;
    double videoLayoutHeight = 225;
    if (_videoPlayerController.value.isInitialized) {
      LogD('屏幕宽高',
          '屏幕宽:${MediaQuery.of(context).size.width}  高：${MediaQuery.of(context).size.width}');
      LogD('视频宽高',
          '视频宽:${_videoPlayerController.value.size.width} 视频高:${_videoPlayerController.value.size.height}');
      LogD('视频宽高比',
          '视频宽高比:${_videoPlayerController.value.size.width / _videoPlayerController.value.size.height}');

      if (_videoPlayerController.value.size.width >
          _videoPlayerController.value.size.height) {
        // 以宽度为主，计算高度 屏幕宽度计算屏幕高度 = 屏幕宽度*9/16
        videoLayoutHeight = videoLayoutWidth * 9 / 16;
      } else {
        // 计算高度
        double screenHeight = MediaQuery.of(context).size.width * 16 / 9;
        if (screenHeight > widget.contentHeight) {
          // 如果高度超出容器高度
          // 以高度为主，缩小宽度
          videoLayoutHeight = widget.contentHeight;
          videoLayoutWidth = videoLayoutHeight * 9 / 16;
          scale = videoLayoutWidth / MediaQuery.of(context).size.width;
        } else {
          videoLayoutHeight = widget.contentHeight;
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _playOrPause();
            },
            child: _getVideoPlayer(videoLayoutWidth, videoLayoutHeight, scale),
          ),

          // 右侧按钮
          // Positioned(
          //     right: 10,
          //     bottom: 110,
          //     child: VideoRightBarWidget(
          //       video: widget.video,
          //       showFocusButton: widget.showFocusButton,
          //       onClickComment: (){
          //         // showBottomComment();
          //       },
          //       onClickShare: (){
          //         // showBottomShare();
          //       },
          //       onClickHeader: (){
          //         widget.onClickHeader?.call();
          //       },
          //     )),

          // 底部黑胶旋转
          // Positioned(
          //     right: 2,
          //     bottom: 20,
          //     child: VinylDisk(video: widget.video,)),

          // 底部关键词
          // Positioned(
          //   left: 12,
          //   bottom: 20,
          //   child: VideoBottomBarWidget(video: widget.video,),
          // )

          // 进度条
          // Positioned(
          //   left: 0,
          //   bottom: 0,
          //   right: 0, // 要么给个宽度，要么加right。无限宽度会报错
          //   // width: MediaQuery.of(context).size.width,
          //   child: VideoProgressIndicator(_videoPlayerController,
          //       colors: VideoProgressColors(
          //           playedColor: Colors.white60,
          //           bufferedColor: Colors.grey,
          //           backgroundColor: Colors.black),
          //       allowScrubbing: true),
          // )
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: _buildVideoProgressSlider(),
          )
        ],
      ),
    );
  }

  _buildVideoProgressSlider() {
    // VideoProgressIndicator(_videoPlayerController,
    //       colors: VideoProgressColors(
    //           playedColor: Colors.white60,
    //           bufferedColor: Colors.grey,
    //           backgroundColor: Colors.black),
    //       allowScrubbing: true)
    return Slider(
      activeColor: Colors.white60,
        max: _videoPlayerController.value.duration.inMilliseconds.truncateToDouble(),
        value: _videoPlayerController.value.position.inMilliseconds
            .truncateToDouble(),
        onChanged: (newRating) {
          _videoPlayerController
              .seekTo(Duration(milliseconds: newRating.truncate()));
        });
  }

  _getVideoPlayer(
      double videoLayoutWidth, double videoLayoutHeight, double scale) {
    return Stack(
      children: [
        Container(
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Transform.scale(
            scale: scale,
            child: Container(
                width: videoLayoutWidth,
                height: videoLayoutHeight,
                child: VideoPlayer(_videoPlayerController)),
          ),
        ),
        _playing == true ? Container() : _getPauseButton(),
      ],
    );
  }

  _getPauseButton() {
    return Center(
      child: Icon(
        Icons.play_arrow,
        size: 100,
        color: Color(0x4CBDBDBD),
      ),
    );
  }

  //展示评论
  // void showBottomComment() {
  //   EasyLoading.showToast('评论列表待开发');
  //
  // }

  //展示分享布局
  // void showBottomShare() {
  //   showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true, //可滚动 解除showModalBottomSheet最大显示屏幕一半的限制
  //       shape: RoundedRectangleBorder(borderRadius: const BorderRadius.only(
  //         topLeft: Radius.circular(10),
  //         topRight: Radius.circular(10),
  //       ),),
  //       // backgroundColor: ColorRes.color_1,
  //       builder: (context){
  //         return VideoShareWidget();
  //       });
  // }
}

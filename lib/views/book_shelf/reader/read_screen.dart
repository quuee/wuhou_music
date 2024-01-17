import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:wuhoumusic/common_widgets/custome_drawer.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/utils/audio_service/common.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/views/book_shelf/reader/read_controller.dart';
import 'package:wuhoumusic/views/book_shelf/reader/text_composition/book_painter.dart';
import 'package:wuhoumusic/views/book_shelf/reader/text_composition/current_paper.dart';
import 'package:wuhoumusic/views/book_shelf/reader/text_composition/papter_point.dart';

// class ReadScreen extends GetView<ReadController> {
//   const ReadScreen({super.key});
// }

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> with TickerProviderStateMixin {
  static final WHAudioPlayerHandler _audioHandler =
      GetIt.I<WHAudioPlayerHandler>();

  late ReadController readController;
  late Size size;

  late ValueNotifier<PaperPoint> p; // 翻页控制点
  Point<double> currentA = const Point(0, 0); // a面
  late Offset downPos;
  bool isNext = false; // 是否翻页到下一页
  bool isAnimation = false; // 是否正在执行翻页
  late AnimationController animationTurnPageController;

  int handlerIndex =-1;

  @override
  void initState() {
    readController = Get.find<ReadController>();
    size = readController.size;
    p = ValueNotifier(PaperPoint(const Point(0, 0), const Size(0, 0)));
    animationTurnPageController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600))
          ..addListener(() {
            if (isNext) {
              /// 翻页
              p.value = PaperPoint(
                  Point(
                      currentA.x -
                          (currentA.x + size.width) *
                              animationTurnPageController.value,
                      currentA.y +
                          (size.height - currentA.y) *
                              animationTurnPageController.value),
                  size);
            } else {
              /// 不翻页 回到原始位置
              p.value = PaperPoint(
                  Point(
                    currentA.x +
                        (size.width - currentA.x) *
                            animationTurnPageController.value,
                    currentA.y +
                        (size.height - currentA.y) *
                            animationTurnPageController.value,
                  ),
                  size);
            }
          })
          ..addStatusListener((status) async {
            if (status == AnimationStatus.completed) {
              // 动画结束后
              isAnimation = false;
              if (isNext) {
                LogD('翻页addStatusListener', '记录翻页动作');
                readController.isAlPath.value = true;
                await readController.nextPage();
              }
            }
          });

    _audioHandler.customState.listen((event) {
      CustomEvent e = event as CustomEvent;
      handlerIndex = e.handlerIndex;
    });
    super.initState();
  }

  @override
  void dispose() {
    animationTurnPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GetBuilder<ReadController>(
        builder: (_) {
          if (_.loadingStatus == LoadingStatus.loading) {
            return Center(
              child: Text('加载中'),
            );
          }

          return LayoutBuilder(builder: (context, dimens) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (details) {
                if (isAnimation) {
                  return;
                }
                if (details.globalPosition.dx > size.width * 1 / 3 &&
                    details.globalPosition.dx < size.width * 2 / 3 &&
                    details.globalPosition.dy > size.height * 3 / 8 &&
                    details.globalPosition.dy < size.height * 5 / 8) {
                  if (_.menuShowStatus) {
                    _.menuAnimationController.reverse();
                    _.menuShowStatus = false;
                  } else {
                    _.menuAnimationController.forward();
                    _.menuShowStatus = true;
                  }
                } else {
                  // 如果上下栏菜单呼出，点击无效
                  if (!_.menuShowStatus) {
                    if (details.globalPosition.dx < size.width / 2) {
                      isAnimation = true;
                      isNext = false;
                      currentA = Point(-100, size.height - 100);
                      readController.updateAlPath(false);
                      _.previousPage();
                      animationTurnPageController.forward(
                        from: 0,
                      );
                    } else {
                      LogD('点击坐标',
                          'dx:${details.localPosition.dx},dy:${details.localPosition.dy}');
                      isAnimation = true;
                      currentA = Point(
                          details.localPosition.dx, details.localPosition.dy);
                      p.value = PaperPoint(
                          Point(details.localPosition.dx,
                              details.localPosition.dy),
                          size);
                      isNext = true;
                      readController.updateAlPath(false);
                      animationTurnPageController.forward(
                        from: 0,
                      );
                    }
                  }
                }
              },
              onPanDown: (d) {
                if (_.menuShowStatus) {
                  return;
                }
                downPos = d.localPosition;
              },
              onPanUpdate: (d) {
                if (_.menuShowStatus) {
                  return;
                }
                if (isAnimation) {
                  return;
                }
                var move = d.localPosition;
                // 临界值取消更新
                if (move.dx >= size.width ||
                    move.dx < 0 ||
                    move.dy >= size.height ||
                    move.dy < 0) {
                  return;
                }
                if (downPos.dx < size.width / 2) {
                  return;
                }

                if (readController.isAlPath.value) {
                  readController.updateAlPath(false);
                }
                if (downPos.dy > size.height / 3 &&
                    downPos.dy < size.height * 2 / 3) {
                  // 横向翻页
                  currentA = Point(move.dx, size.height - 1);
                  p.value = PaperPoint(Point(move.dx, size.height - 1), size);
                } else {
                  // 右下角翻页
                  currentA = Point(move.dx, move.dy);
                  p.value = PaperPoint(Point(move.dx, move.dy), size);
                }
                if ((size.width - move.dx) / size.width > 1 / 3) {
                  isNext = true;
                } else {
                  isNext = false;
                }
              },
              onPanEnd: (d) {
                if (_.menuShowStatus) {
                  return;
                }
                if (isAnimation) {
                  return;
                }
                readController.updateAlPath(false);
                isAnimation = true;
                animationTurnPageController.forward(
                  from: 0,
                );
              },
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  // 下一页
                  _.pageIndex >= _.textPages.length - 1
                      ? ClipPath(child: _.getNextPageWidget())
                      : ClipPath(child: _.getPageWidget(_.pageIndex + 1)),
                  // 当前页 A区，根据路径会被剪裁，露出下一页的内容
                  ClipPath(
                    child: _.getPageWidget(_.pageIndex),
                    clipper: _.isAlPath.value
                        ? null
                        : CurrentPaperClipPath(p, isNext),
                  ),
                  // 最上面只绘制B区域和阴影(就是翻页的特效)
                  CustomPaint(
                    size: size,
                    painter: BookPainter(p, Colors.grey),
                  ),
                  // 菜单层
                  // 顶部
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SlideTransition(
                      position: _.menuTopAnimationProgress,
                      child: _buildAppBar(),
                    ),
                  ),
                  // 底部
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SlideTransition(
                      position: _.menuBottomAnimationProgress,
                      child: _buildBottomMenu(),
                    ),
                  )
                ],
              ),
            );
          });
        },
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () async {
              // 不能重复点击
              if(handlerIndex == 1){
                return;
              }
              await _audioHandler.customAction(
                  'switchToHandler', <String, dynamic>{'index': 1});

              for (int i = readController.currentChapterIndex;
              i < readController.chapters.length;
              i++) {
                LogD('tts阅读章节', '第$i章：${readController.chapters[i].chapterTitle}');
                // readController.textPages动画翻页会重复一次之前的章节数据
                for (int j = readController.pageIndex;
                j < readController.textPages.length;
                j++) {
                  final lines = readController.textPages[j].lines;
                  String text = '';
                  for (var p = 0; p < lines.length - 1; p++) {
                    text += lines[p].text;
                  }
                  LogD('tts阅读书页', '第$j页:$text');
                  List<String> split = text.split('\n');
                  List<MediaItem> queue = [];
                  for (var n = 0; n < split.length; n++) {
                    var m = MediaItem(
                        id: n.toString(),
                        title: readController
                            .chapters[readController.currentChapterIndex]
                            .chapterTitle,
                        extras: <String, String>{'text': split[n]});
                    queue.add(m);
                  }
                  await _audioHandler.updateQueue(queue);
                  // 如果切换到音乐播放，这里for会执行完（要等待耗时），但是实际不需要执行完。在handlerIndex改变后退出
                  if(handlerIndex == 0){
                    return;
                  }
                  await _audioHandler.play();
                  // await _audioHandler.stop();

                  // 翻页(如果不在阅读页，不需要翻页)
                  // LogD('判断是否在阅读页面:', mounted ? '是' : '否');
                  // if (mounted) {
                  //   //判断用户是否退出页面
                  //   isAnimation = true;
                  //   currentA = Point(size.width, size.height);
                  //   p.value = PaperPoint(
                  //       Point(size.width - 50, size.height - 50), size);
                  //   isNext = true;
                  //   readController.updateAlPath(false);
                  //   animationTurnPageController.forward(
                  //     from: 0,
                  //   );
                  // }

                  // 动画翻页会重复章节，而且这里下一页(章)需要加await阻塞下
                  await readController.nextPage();

                  // 阅读停止，需要记录最后的位置
                }
              }
            },
            icon: Icon(Icons.headset))
      ],
    );
  }

  _buildBottomMenu() {
    var bottomMenuStyle = TextStyle(fontSize: 18);
    return Container(
      color: Colors.grey,
      height: readController.size.height / 8,
      child: Column(
        children: [
          //第一行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Text('上一章'),
                  )),
              Expanded(
                flex: 5,
                child: Slider(max: 100, value: 1, onChanged: (v) {}),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Text('下一章'),
                  )),
            ],
          ),
          // 第二行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildChapterList(bottomMenuStyle),
              Text(
                '亮度',
                style: bottomMenuStyle,
              ),
              _buildSetting(bottomMenuStyle),
              Text(
                '更多',
                style: bottomMenuStyle,
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildChapterList(TextStyle bottomMenuStyle) {
    return InkWell(
      child: Text(
        '目录',
        style: bottomMenuStyle,
      ),
      onTap: () {
        double boxHeight = 40.0;
        RDrawer.open(
            Drawer(
              child: ListView.builder(
                  controller: ScrollController(
                      initialScrollOffset: readController.currentChapterIndex *
                          boxHeight), // 打开目录 滚到当前阅读章节 ListView需要撑满高度
                  itemCount: readController.chapters.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: boxHeight,
                      child: InkWell(
                          onTap: () {
                            readController.gotoChapter(index);
                            RDrawer.close();
                          },
                          child: Text(
                            readController.chapters[index].chapterTitle ?? '',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                    );
                  }),
            ),
            width: size.width * 3 / 4);
      },
    );
  }

  _buildSetting(TextStyle bottomMenuStyle) {
    double textWidth = 80;
    return InkWell(
      child: Text(
        '设置',
        style: bottomMenuStyle,
      ),
      onTap: () {
        readController.menuAnimationController.reverse();
        Get.bottomSheet(GetBuilder<ReadController>(builder: (_) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: size.height / 5,
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 5 / 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: textWidth,
                        child: Text('字号大小'),
                      ),
                      IconButton(
                          onPressed: () {
                            double fsize =
                                double.parse(_.fontSizeController.value.text);
                            fsize--;
                            _.updateFontSizeOrFontHeight(fsize, -1);
                          },
                          icon: Icon(Icons.remove)),
                      Text(_.fontSizeController.text),
                      IconButton(
                          onPressed: () {
                            double fsize =
                                double.parse(_.fontSizeController.value.text);
                            fsize++;
                            _.updateFontSizeOrFontHeight(fsize, -1);
                          },
                          icon: Icon(Icons.add)),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height / 5 / 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: textWidth,
                        child: Text('字间距'),
                      ),
                      IconButton(
                          onPressed: () {
                            double fHeight =
                                double.parse(_.fontHeightController.value.text);
                            fHeight -= 0.1;
                            _.updateFontSizeOrFontHeight(-1, fHeight);
                          },
                          icon: Icon(Icons.remove)),
                      Text(_.fontHeightController.text.substring(0, 3)),
                      IconButton(
                          onPressed: () {
                            double fHeight =
                                double.parse(_.fontHeightController.value.text);
                            fHeight += 0.1;
                            _.updateFontSizeOrFontHeight(-1, fHeight);
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height / 5 / 5 * 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: _buildBackgroundList()),
                    ],
                  ),
                ),
              ],
            ),
          );
        }), backgroundColor: Colors.grey, barrierColor: Colors.transparent);
      },
    );
  }

  _buildBackgroundList() {
    double height = size.height / 5 / 5 * 3 - 20;
    // double width = 40;
    var mfit = BoxFit.scaleDown;
    // {背景色：字体颜色}
    List<Map<String, int>> bgs = [
      {R.images.bg001: 0xdd000000},
      {R.images.bg002: 0xdd000000},
      {R.images.bg003: 0xdd000000},
      {R.images.bg004: 0xdd000000},
      {R.images.bg005: 0xB3FFFFFF},
      {R.images.bg006: 0xdd000000},
      {R.images.bg007: 0xB3FFFFFF},
      {R.images.bg008: 0xdd000000},
    ];
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: bgs.length,
          itemBuilder: (c, index) {
            return InkWell(
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: Image.asset(
                  bgs[index].keys.first,
                  height: height,
                  // width: width,
                  fit: mfit,
                ),
              ),
              onTap: () {
                readController.updateBackground(bgs[index]);
              },
            );
          },
          separatorBuilder: (c, i) {
            return SizedBox(
              width: 20,
            );
          }),
    );
  }
}

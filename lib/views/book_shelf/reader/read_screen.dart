import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/custome_drawer.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
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
  late ReadController readController;
  late var size;

  // 翻页控制点
  late ValueNotifier<PaperPoint> p;
  Point<double> currentA = const Point(0, 0); // a面
  late Offset downPos;
  bool isNext = false; // 是否翻页到下一页
  bool isAnimation = false; // 是否正在执行翻页
  late AnimationController animationTurnPageController;

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
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // 动画结束后
              isAnimation = false;
              if (isNext) {
                LogD('翻页addStatusListener', '记录翻页动作');
                readController.isAlPath.value = true;
                readController.nextPage();

              }
            }
          });
    super.initState();
  }

  @override
  void dispose() {
    animationTurnPageController.dispose();
    readController.dispose();
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
                  if (_.menuAnimationController.isCompleted) {
                    _.menuAnimationController.reverse();
                  } else {
                    _.menuAnimationController.forward();
                  }
                } else {
                  // 如果上下栏菜单呼出，点击无效
                  if (_.menuAnimationController.isDismissed) {
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
                      isAnimation = true;
                      currentA = Point(details.localPosition.dx, details.localPosition.dy);
                      p.value = PaperPoint(Point(details.localPosition.dx,details.localPosition.dy), size);
                      isNext = true;
                      readController.updateAlPath(false);
                      animationTurnPageController.forward(
                        from: 0,
                      );
                    }
                  }
                }
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
                    clipper: _.isAlPath.value ? null : CurrentPaperClipPath(p, isNext),
                  ), // 使用setState不会抖，用obx会抖，又重新刷新了一遍的感觉
                  // 最上面只绘制B区域和阴影
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
                      child: AppBar(
                        actions: [Icon(Icons.headset)],
                      ),
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
              onPanDown: (d) {
                downPos = d.localPosition;
              },
              onPanUpdate: (d) {
                // LogD("onPanUpdate","onPanUpdate---${d.globalPosition}---${d.localPosition}---${d.delta}");
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
                if (isAnimation) {
                  return;
                }
                readController.updateAlPath(false);
                isAnimation = true;
                animationTurnPageController.forward(
                  from: 0,
                );
              },
            );
          });
        },
      ),
    );
  }

  _buildBottomMenu() {
    return Container(
      color: Colors.white70,
      child: Column(
        children: [
          //第一行
          Row(
            children: [
              Expanded(flex: 1, child: Text('上一章')),
              Expanded(
                flex: 6,
                child: Slider(max: 100, value: 1, onChanged: (v) {}),
              ),
              Expanded(flex: 1, child: Text('下一章')),
            ],
          ),
          // 第二行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Text('目录'),
                onTap: () {
                  RDrawer.open(
                      Drawer(
                        child: ListView.builder(
                            itemCount: readController.chapters.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(readController
                                        .chapters[index].chapterTitle ??
                                    ''),
                                subtitle: Text('第$index章'),
                                onTap: () {
                                  readController.gotoChapter(index);
                                },
                              );
                            }),
                      ),
                      width: size.width * 2 / 3);
                },
              ),
              Text('亮度'),
              Text('设置'),
              Text('更多'),
            ],
          )
        ],
      ),
    );
  }
}

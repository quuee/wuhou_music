import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/views/book_shelf/reader/read_test_controller.dart';
import 'package:wuhoumusic/views/book_shelf/reader/text_composition/book_painter.dart';
import 'package:wuhoumusic/views/book_shelf/reader/text_composition/current_paper.dart';
import 'package:wuhoumusic/views/book_shelf/reader/text_composition/papter_point.dart';

class ReadScreenText extends StatefulWidget {
  const ReadScreenText({super.key});

  @override
  State<ReadScreenText> createState() => _ReadScreenTextState();
}

class _ReadScreenTextState extends State<ReadScreenText>
    with TickerProviderStateMixin {
  var size = WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
  Point<double> currentA = const Point(0, 0); // a面
  late Offset downPos;
  bool isNext = false; // 是否翻页到下一页
  bool isAlPath = true; //
  bool isAnimation = false; // 是否正在执行翻页

  late ReadTestController readTestController;

  late AnimationController animationTurnPageController;
  // 翻页控制点
  late ValueNotifier<PaperPoint> p;

  int currentIndex = 0;

  @override
  void initState() {
    readTestController = Get.find<ReadTestController>();
    p = ValueNotifier(PaperPoint(const Point(0, 0), const Size(0, 0)));
    animationTurnPageController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
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
              isAnimation = false;
              if (isNext) {
                LogD('翻页addStatusListener', '记录翻页动作');
                isAlPath = true;
                currentIndex++;
                // widget.nextCallBack?.call(widget.controller.currentIndex + 1);
                setState(() {});
              }
            }
            if (status == AnimationStatus.dismissed) {
              //起点停止
              // print("起点停止");
            }
          });
    super.initState();
  }

  @override
  void dispose() {
    animationTurnPageController.dispose();
    readTestController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<ReadTestController>(
      builder: (_) {
        return GestureDetector(
          child: Stack(
            children: [
              currentIndex == _.dataList.length - 1
                  ? Center(
                      child: Text('没有了'),
                    )
                  // 下一页
                  : ClipPath(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.green,
                        width: size.width,
                        height: size.height,
                        child: Text(
                          _.dataList[currentIndex + 1],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
              // // 当前页
              ClipPath(
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height,
                  color: Colors.blue,
                  child: Text(
                    _.dataList[currentIndex],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                clipper: isAlPath ? null : CurrentPaperClipPath(p, isNext),
              ),

              // 最上面只绘制B区域和阴影
              CustomPaint(
                size: size,
                painter: BookPainter(p, Colors.white60),
              ),
            ],
          ),
          onPanDown: (d) {
            downPos = d.localPosition;
          },
          onPanUpdate: (d) {
            if (isAnimation) {
              return;
            }
            if (currentIndex == _.dataList.length - 1) {
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
            if (isAlPath) {
              setState(() {
                isAlPath = false;
              });
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

            /// 手指首次触摸屏幕左侧区域
            if (downPos.dx < size.width / 2) {
              if (currentIndex == 0) {
                // widget.lastCallBack?.call(widget.controller.currentIndex);
                return;
              }
              // widget.lastCallBack?.call(widget.controller.currentIndex);
              // last();
              return;
            }

            ///下一页
            if (currentIndex == _.dataList.length - 1) {
              // widget.nextCallBack?.call(widget.pageCount);
              return;
            }
            setState(() {
              isAlPath = false;
            });
            isAnimation = true;
            animationTurnPageController.forward(
              from: 0,
            );
          },
          onTapUp: (details) {
            final size = MediaQuery.of(context).size;
            if (details.globalPosition.dx > size.width * 1 / 3 &&
                details.globalPosition.dx < size.width * 2 / 3 &&
                details.globalPosition.dy > size.height * 3 / 8 &&
                details.globalPosition.dy < size.height * 5 / 8) {
            } else {
              if (details.globalPosition.dx < size.width / 2) {
                _previous();
              } else {
                _next();
              }
            }
          },
        );
      },
    ));
  }

  _previous() {
    if (currentIndex <= 0) {
      return;
    }
    isAnimation = true;
    setState(() {
      isAlPath = false;
      currentA = Point(-200, size.height - 100);
      isNext = false;
    });

    currentIndex--;
    animationTurnPageController.forward(
      from: 0,
    );
  }

  _next() {
    if (currentIndex >= readTestController.dataList.length - 1) {
      return;
    }
    setState(() {
      isAlPath = false;
      isNext = true;
      currentA = Point(size.width - 50, size.height - 50);
    });
    isAnimation = true;
    animationTurnPageController.forward(
      from: 0,
    );
  }
}

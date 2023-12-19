
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/custome_drawer.dart';
import 'package:wuhoumusic/views/book_shelf/reader/read_controller.dart';

class ReadScreen extends GetView<ReadController> {
  const ReadScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Material(
      child: GetBuilder<ReadController>(
        builder: (_) {
          if (_.textPages.isEmpty) {
            return Center(
              child: Text('加载中'),
            );
          }
          return LayoutBuilder(builder: (context, dimens) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              //手指水平滑动取消时的回调函数
              onHorizontalDragCancel: () => _.isForward = null,
              //手指水平滑动时的回调函数
              onHorizontalDragUpdate: (details) => _.turnPage(details, dimens),
              //手指水平滑动结束时的回调函数
              onHorizontalDragEnd: (details) => _.onDragFinish(),
              onTapUp: (details) {
                final size = MediaQuery.of(context).size;
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
                      _.previousPage();
                    } else {
                      _.nextPage();
                    }
                  }
                }
              },
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[

                  _.getPageWidget(_.pageIndex),
                  // CustomPaint(
                  //   size: controller.size,
                  //   painter: BookPainter(
                  //     _.p,
                  //     Colors.grey,
                  //   ),
                  // ),
                  // 菜单层
                  // 顶部
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SlideTransition(
                      position: _.menuTopAnimationProgress,
                      child: AppBar(
                        actions: [
                          Icon(Icons.headset)
                        ],
                      ),
                    ),
                  ),
                  //底部
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
                            itemCount: controller.chapters.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                    controller.chapters[index].chapterTitle ??
                                        ''),
                                subtitle: Text('第$index章'),
                                onTap: () {
                                  controller.gotoChapter(index);
                                },
                              );
                            }),
                      ),
                      width: controller.size.width * 2 / 3);
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

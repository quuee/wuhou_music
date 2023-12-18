import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/views/book_shelf/reader/read_controller.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({super.key});

  static final ReadController readController = Get.find<ReadController>();

  @override
  Widget build(BuildContext context) {
    final colorStyle = TextStyle(color: Color(0xFF303133));

    return Material(
      child: GetBuilder<ReadController>(
        builder: (_) {

          if (readController.textPages.isEmpty) {
            return Center(
              child: Text('加载中'),
            );
          }
          return LayoutBuilder(builder: (context, dimens) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              //手指水平滑动取消时的回调函数
              onHorizontalDragCancel: () => readController.isForward = null,
              //手指水平滑动时的回调函数
              onHorizontalDragUpdate: (details) => readController.turnPage(details, dimens),
              //手指水平滑动结束时的回调函数
              onHorizontalDragEnd: (details) => readController.onDragFinish(),
              onTapUp: (details) {
                final size = MediaQuery.of(context).size;
                if (details.globalPosition.dx > size.width * 3 / 8 &&
                    details.globalPosition.dx < size.width * 5 / 8 &&
                    details.globalPosition.dy > size.height * 3 / 8 &&
                    details.globalPosition.dy < size.height * 5 / 8) {
                  // readController.toggleMenuDialog(context);
                } else {
                  // if (readController.isShowMenu) return;
                  if (details.globalPosition.dx < size.width / 2) {
                    readController.previousPage();
                  } else {
                    readController.nextPage();
                  }
                }
              },
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  /// 换个思路 页面文字自己控制，动画归动画，参考bookfx项目
                  readController.pageIndex+1 >= readController.textPages.length ?
                  // 最底层
                  Container(
                    decoration: getDecoration(
                      '#FFFFFFCC',
                      Color(0xFFFFFFCC),
                    ),
                    // color: widget.controller.config.backgroundColor,
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("这是底线（最后一页）", style: colorStyle),
                        SizedBox(height: 10),
                        Text("已读完", style: colorStyle),
                      ],
                    ),
                  ) : readController.getPageWidget(readController.pageIndex+1),
                  readController.getPageWidget(readController.pageIndex),

                  // 动画层 当前页 下一页
                  // ...pageWidget,// 拼接数组

                  // 菜单层
                  // if (widget.controller.isShowMenu && widget.controller.menuBuilder != null)
                  //   widget.controller.menuBuilder!(widget.controller),

                ],
              ),
            );
          });
        },
      ),
    );
  }

  Decoration getDecoration(String background, Color backgroundColor) {
    DecorationImage? image;
    if (background.isEmpty || background == 'null') {
    } else if (background.startsWith("assets")) {
      try {
        image = DecorationImage(
          image: AssetImage(background),
          fit: BoxFit.fill,
          onError: (_, __) {
            print(_);
            print(__);
            image = null;
          },
        );
      } catch (e) {}
    } else {
      final file = File(background);
      if (file.existsSync()) {
        try {
          image = DecorationImage(
            image: FileImage(file),
            fit: BoxFit.fill,
            onError: (_, __) => image = null,
          );
        } catch (e) {}
      }
    }
    return BoxDecoration(
      color: backgroundColor,
      image: image,
    );
  }
}


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/views/book_shelf/reader/read_controller.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({super.key});

  static final ReadController readController = Get.find<ReadController>();

  @override
  Widget build(BuildContext context) {
    final colorStyle = TextStyle(color: Color(0xFF303133));
    return Material(
      child: LayoutBuilder(
        builder: (context, dimens) => RawKeyboardListener(
          focusNode: FocusNode(),
          autofocus: true,
          onKey: (event) {
            // if (readController.isShowMenu) return;
            if (event.runtimeType.toString() == 'RawKeyUpEvent') return;
            if (event.data is RawKeyEventDataMacOs ||
                event.data is RawKeyEventDataLinux ||
                event.data is RawKeyEventDataWindows) {
              final logicalKey = event.data.logicalKey;
              print(logicalKey);
              if (logicalKey == LogicalKeyboardKey.arrowUp) {
                // readController.previousPage();
              } else if (logicalKey == LogicalKeyboardKey.arrowLeft) {
                // readController.previousPage();
              } else if (logicalKey == LogicalKeyboardKey.arrowDown) {
                // readController.nextPage();
              } else if (logicalKey == LogicalKeyboardKey.arrowRight) {
                // readController.nextPage();
              } else if (logicalKey == LogicalKeyboardKey.home) {
                // readController.goToPage(readController.firstIndex);
              } else if (logicalKey == LogicalKeyboardKey.end) {
                // readController.goToPage(widget.controller.lastIndex);
              } else if (logicalKey == LogicalKeyboardKey.enter ||
                  logicalKey == LogicalKeyboardKey.numpadEnter) {
                // readController.toggleMenuDialog(context);
              } else if (logicalKey == LogicalKeyboardKey.escape) {
                Navigator.of(context).pop();
              }
            }
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            // onHorizontalDragCancel: () => readController.isForward = null,
            // onHorizontalDragUpdate: (details) => readController.turnPage(details, dimens),
            // onHorizontalDragEnd: (details) => readController.onDragFinish(),
            onTapUp: (details) {
              final size = MediaQuery.of(context).size;
              if (details.globalPosition.dx > size.width * 3 / 8 &&
                  details.globalPosition.dx < size.width * 5 / 8 &&
                  details.globalPosition.dy > size.height * 3 / 8 &&
                  details.globalPosition.dy < size.height * 5 / 8) {
                // readController.toggleMenuDialog(context);
              } else {
                // if (readController.isShowMenu) return;
                // if (details.globalPosition.dx < size.width / 2) {
                //   if (readController.config.oneHand) {
                //     readController.nextPage();
                //   } else {
                //     readController.previousPage();
                //   }
                // } else {
                //   readController.nextPage();
                // }
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
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
                ),
                ...readController.getPageWidget(),

                // if (widget.controller.isShowMenu && widget.controller.menuBuilder != null)
                //   widget.controller.menuBuilder!(widget.controller),
              ],
            ),
          ),
        ),
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

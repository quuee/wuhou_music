// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:wuhoumusic/common_widgets/custome_drawer.dart';
// import 'package:wuhoumusic/views/book_shelf/reader/read_controller.dart';
//
// class ReaderMainScreen extends StatefulWidget {
//   const ReaderMainScreen({super.key});
//
//   @override
//   State<ReaderMainScreen> createState() => _ReaderMainScreenState();
// }
//
// class _ReaderMainScreenState extends State<ReaderMainScreen>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey _ignorePointerKey = GlobalKey();
//   bool _shouldIgnorePointer = false;
//   late AnimationController menuAnimationController;
//   late Animation<Offset> menuTopAnimationProgress;
//   late Animation<Offset> menuBottomAnimationProgress;
//
//   ReadController readController = Get.find<ReadController>();
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     menuAnimationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 300));
//     menuTopAnimationProgress = menuAnimationController
//         .drive(Tween(begin: Offset(0.0, -1.0), end: Offset.zero));
//     menuBottomAnimationProgress = menuAnimationController
//         .drive(Tween(begin: Offset(0.0, 1.0), end: Offset.zero));
//     menuAnimationController.addStatusListener((state) {
//       if (state == AnimationStatus.completed) {
//         _setIgnorePointer(true);
//       } else {
//         _setIgnorePointer(false);
//       }
//     });
//   }
//
//   _setIgnorePointer(bool value) {
//     if (_shouldIgnorePointer == value) return;
//     _shouldIgnorePointer = value;
//     if (_ignorePointerKey.currentContext != null) {
//       final RenderIgnorePointer renderBox = _ignorePointerKey.currentContext!
//           .findRenderObject()! as RenderIgnorePointer;
//       renderBox.ignoring = _shouldIgnorePointer;
//     }
//   }
//
//   @override
//   void dispose() {
//     menuAnimationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//               child: GestureDetector(
//             behavior: HitTestBehavior.translucent,
//             onTap: () {
//               if (menuAnimationController.isCompleted) {
//                 menuAnimationController.reverse();
//               } else {
//                 menuAnimationController.forward();
//               }
//             },
//             child: IgnorePointer(
//               key: _ignorePointerKey,
//               ignoring: _shouldIgnorePointer,
//               child: _buildChapter(),
//             ),
//           )),
//           // 顶部
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: SlideTransition(
//               position: menuTopAnimationProgress,
//               child: AppBar(),
//             ),
//           ),
//           //底部
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: SlideTransition(
//               position: menuBottomAnimationProgress,
//               child: _buildBottomMenu(),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   _buildBottomMenu() {
//     return Container(
//       color: Colors.white70,
//       child: Column(
//         children: [
//           //第一行
//           Row(
//             children: [
//               Expanded(flex: 1, child: Text('上一章')),
//               Expanded(
//                 flex: 6,
//                 child: Slider(max: 100, value: 1, onChanged: (v) {}),
//               ),
//               Expanded(flex: 1, child: Text('下一章')),
//             ],
//           ),
//           // 第二行
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               InkWell(
//                 child: Text('目录'),
//                 onTap: () {
//                   RDrawer.open(
//                       Drawer(
//                         child: ListView.builder(
//                             itemCount: readController.chapters.length,
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 title: Text(readController
//                                         .chapters[index].chapterTitle ??
//                                     ''),
//                                 subtitle: Text('第$index章'),
//                                 onTap: () {
//                                   // double height = 0.0;
//                                   // var list =
//                                   //     chapterCacheInfoList.sublist(0, index);
//                                   // for (int i = 0; i < list.length; i++) {
//                                   //   height += list[i].getChapterHeight();
//                                   // }
//                                   //
//                                   // LogD('跳转高度', height.toString());
//                                   // chapterScro.jumpTo(height);
//                                 },
//                               );
//                             }),
//                       ),
//                       width: MediaQuery.of(context).size.width * 2 / 3);
//                 },
//               ),
//               Text('亮度'),
//               Text('设置'),
//               Text('更多'),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   _buildChapter() {
//     return GetBuilder<ReadController>(
//       builder: (_) {
//         if (_.currentChapterParagraph.isEmpty) {
//           return Center(
//             child: Text('加载中'),
//           );
//         }
//         return Material(
//           child: LayoutBuilder(
//             builder: (context, dimens) => RawKeyboardListener(
//               focusNode: FocusNode(),
//               autofocus: true,
//               onKey: (event) {
//                 if (event.runtimeType.toString() == 'RawKeyUpEvent') return;
//                 if (event.data is RawKeyEventDataMacOs ||
//                     event.data is RawKeyEventDataLinux ||
//                     event.data is RawKeyEventDataWindows) {
//                   final logicalKey = event.data.logicalKey;
//                   print(logicalKey);
//                   if (logicalKey == LogicalKeyboardKey.arrowUp) {
//                     readController.previousPage();
//                   } else if (logicalKey == LogicalKeyboardKey.arrowLeft) {
//                     readController.previousPage();
//                   } else if (logicalKey == LogicalKeyboardKey.arrowDown) {
//                     readController.nextPage();
//                   } else if (logicalKey == LogicalKeyboardKey.arrowRight) {
//                     readController.nextPage();
//                   } else if (logicalKey == LogicalKeyboardKey.home) {
//                     readController.goToPage(readController.firstIndex);
//                   } else if (logicalKey == LogicalKeyboardKey.end) {
//                     readController.goToPage(readController.lastIndex);
//                   } else if (logicalKey == LogicalKeyboardKey.enter ||
//                       logicalKey == LogicalKeyboardKey.numpadEnter) {
//                     readController.toggleMenuDialog(context);
//                   } else if (logicalKey == LogicalKeyboardKey.escape) {
//                     Navigator.of(context).pop();
//                   }
//                 }
//               },
//               child: GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 onHorizontalDragCancel: () => readController.isForward = null,
//                 onHorizontalDragUpdate: (details) =>
//                     readController.turnPage(details, dimens),
//                 onHorizontalDragEnd: (details) => readController.onDragFinish(),
//                 onTapUp: (details) {
//                   final size = MediaQuery.of(context).size;
//                   if (details.globalPosition.dx > size.width * 3 / 8 &&
//                       details.globalPosition.dx < size.width * 5 / 8 &&
//                       details.globalPosition.dy > size.height * 3 / 8 &&
//                       details.globalPosition.dy < size.height * 5 / 8) {
//
//                   } else {
//                     if (widget.controller.isShowMenu) return;
//                     if (details.globalPosition.dx < size.width / 2) {
//                       if (widget.controller.config.oneHand) {
//                         widget.controller.nextPage();
//                       } else {
//                         widget.controller.previousPage();
//                       }
//                     } else {
//                       widget.controller.nextPage();
//                     }
//                   }
//                 },
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: <Widget>[
//                     Container(
//                       decoration: getDecoration(
//                         widget.controller.config.background,
//                         widget.controller.config.backgroundColor,
//                       ),
//                       // color: widget.controller.config.backgroundColor,
//                       width: double.infinity,
//                       height: double.infinity,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(widget.controller.name ?? ""),
//                           SizedBox(height: 10),
//                           Text("这是底线（最后一页）", style: colorStyle),
//                           SizedBox(height: 10),
//                           Text("已读完", style: colorStyle),
//                         ],
//                       ),
//                     ),
//                     readController.textPages,
//                     if (readController.isShowMenu && widget.controller.menuBuilder != null)
//                       widget.controller.menuBuilder!(widget.controller),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//
//       },
//     );
//   }
//
// }
//

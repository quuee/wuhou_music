// import 'package:flutter/material.dart';
// import 'package:wuhoumusic/views/book_shelf/reader/novel_model.dart';
//
// /// 一个章节的内容
// class ReaderContentScreen extends StatefulWidget {
//   ReaderContentScreen(
//       {super.key,
//       required this.chapterCacheInfo,
//       required this.contentHeight,
//       required this.contentWidth,
//       required this.totalPage});
//
//   ChapterCacheInfo chapterCacheInfo;
//   double contentHeight; // 这些宽度高度设置了一点用都没有的
//   double contentWidth;
//   int totalPage;
//
//   @override
//   State<ReaderContentScreen> createState() => _ReaderContentScreenState();
// }
//
// class _ReaderContentScreenState extends State<ReaderContentScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: widget.contentWidth,
//         height: widget.contentHeight,
//         child: ListView.builder(
//           // shrinkWrap: true, //外面包层有宽度的container 和 shrinkWrap:true 一样不会报错了
//             scrollDirection: Axis.horizontal,
//             physics: PageScrollPhysics(),
//             itemCount: widget.chapterCacheInfo.chapterPageCount,
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: EdgeInsets.only(top: 30),
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 width: widget.contentWidth, // 没有宽度，不会换行
//                 child: Stack(
//                   children: [
//                     Align(
//                       alignment: AlignmentDirectional.topCenter,
//                       child: Text.rich(
//                         TextSpan(
//                             children: widget
//                                 .chapterCacheInfo
//                                 .chapterPageContentCacheInfoList[index]
//                                 .paragraphContents),
//                         // softWrap: true,
//                       ),
//                     ),
//                     Positioned(
//                         bottom: 0,
//                         right: 10,
//                         child: Text('页码:$index' + "/" + widget.totalPage.toString(),
//                             style: TextStyle(color: Colors.grey, fontSize: 12))),
//                     Positioned(
//                         bottom: 0,
//                         left: 10,
//                         child: Text(
//                           widget.chapterCacheInfo.chapterTitle ?? '',
//                           style: TextStyle(color: Colors.grey, fontSize: 12),
//                         )),
//                   ],
//                 ),
//               );
//
//             }),
//       );
//
//   }
// }

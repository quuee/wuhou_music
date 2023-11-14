import 'package:easy_refresh/easy_refresh.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:wuhoumusic/model/book_novel/book_novel_entity.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/utils/event_bus.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/utils/log_util.dart';

class BookShelfPage extends StatefulWidget {
  const BookShelfPage({super.key});

  @override
  State<BookShelfPage> createState() => _BookShelfPageState();
}

class _BookShelfPageState extends State<BookShelfPage>
    with SingleTickerProviderStateMixin {
  List<BookNovelEntity>? books;

  bool isEditStatus = false;

  List<int> _selectedBookIds = [];

  late AnimationController menuAnimationController;
  late Animation<Offset> menuBottomAnimationProgress;

  @override
  void initState() {
    super.initState();
    menuAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    menuBottomAnimationProgress = menuAnimationController
        .drive(Tween(begin: Offset(0.0, 1.0), end: Offset.zero));

    _loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('书架'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                _filePicker();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: EasyRefresh(
              header: ClassicHeader(),
              onRefresh: _loadBooks,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1),
                  itemCount: books?.length,
                  itemBuilder: (context, index) {
                    if (books == null || books!.isEmpty) {
                      return Container(
                        child: Text('暂无数据'),
                      );
                    }
                    return InkWell(
                      key: ValueKey(books![index].id),
                      onTap: () {
                        _openBookNovel(books![index]);
                      },
                      onLongPress: () {
                        // if (menuAnimationController.isCompleted) {
                        //   menuAnimationController.reverse();
                        // } else {
                        //   menuAnimationController.forward();
                        // }
                        menuAnimationController.forward();
                        setState(() {
                          isEditStatus = !isEditStatus;
                        });
                        eventBus.fire(isEditStatus);
                      },
                      child: _buildBookCover(books![index]),
                    );
                  }),
            ),
          ),
          //底部
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: menuBottomAnimationProgress,
              child: _buildBottomMenu(),
            ),
          )
        ],
      ),
    );
  }

  _openBookNovel(BookNovelEntity bookNovelEntity) {
    if (!isEditStatus) {
      Get.toNamed(Routes.reader, arguments: bookNovelEntity);
    }
  }

  _loadBooks() {
    books =
        IsarHelper.instance.isarInstance.bookNovelEntitys.where().findAllSync();
    setState(() {});
  }

  _filePicker() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['txt']);
    if (result != null) {
      LogD('_filePicker',
          result.files.single.name + " - " + result.files.single.path!);
      // 将文件名 文件路径存入isra
      IsarHelper.instance.isarInstance.writeTxn(() async {
        BookNovelEntity bookNovelEntity = BookNovelEntity(
            bookTitle: result.files.single.name,
            localPath: result.files.single.path!);
        IsarHelper.instance.isarInstance.bookNovelEntitys.put(bookNovelEntity);
      });
    } else {
      // User canceled the picker
    }
  }

  _deleteBookNovel(int bookId) {
    IsarHelper.instance.isarInstance.writeTxnSync(() {
      IsarHelper.instance.isarInstance.bookNovelEntitys.deleteSync(bookId);
    });
    setState(() {});
  }

  _buildBookCover(BookNovelEntity bookNovel) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.yellow,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(bookNovel.bookTitle),
                Text(
                  bookNovel.localPath,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          isEditStatus
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Checkbox(
                    value: _selectedBookIds.contains(bookNovel.id!),
                    activeColor: Colors.amber,
                    onChanged: (value) {
                      if (value!) {
                        setState(() {
                          _selectedBookIds.add(bookNovel.id!);
                        });
                      } else {
                        setState(() {
                          _selectedBookIds.remove(bookNovel.id!);
                        });
                      }
                    },
                    shape: CircleBorder(),
                  ))
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  _buildBottomMenu() {
    return Container(
      color: Colors.white70,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('删除'),
              Text('移动'),
              Text('详情'),
              Text('更多'),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isEditStatus = !isEditStatus;
                    });
                    // if (menuAnimationController.isCompleted) {
                    //   menuAnimationController.reverse();
                    // } else {
                    //   menuAnimationController.forward();
                    // }
                    menuAnimationController.reverse();
                    eventBus.fire(isEditStatus);
                  },
                  icon: Icon(Icons.cancel_outlined))
            ],
          )
        ],
      ),
    );
  }
}


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:wuhoumusic/model/book_novel/book_novel_entity.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/utils/log_util.dart';

class BookShelfPage extends StatefulWidget {
  const BookShelfPage({super.key});

  @override
  State<BookShelfPage> createState() => _BookShelfPageState();
}

class _BookShelfPageState extends State<BookShelfPage> {

  List<BookNovelEntity>? books ;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('书架'),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {
              _filePicker();
            }, icon: Icon(Icons.add))
          ],
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1),
            itemCount: books?.length,
            itemBuilder: (context, index) {
              if(books == null || books!.isEmpty){
                return Container(child: Text('暂无数据'),);
              }
              return InkWell(
                onTap: () {
                  _openBookNovel(books![index]);
                },
                onLongPress: (){
                  _deleteBookNovel();
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(books![index].bookTitle),
                      Text(books![index].localPath,overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
              );
            }));
  }

  _openBookNovel(BookNovelEntity bookNovelEntity){
    Get.toNamed(Routes.reader,arguments: bookNovelEntity);
  }

  _loadBooks(){
    books = IsarHelper.instance.isarInstance.bookNovelEntitys.where().findAllSync();
    setState(() {});
  }
  _filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['txt']);
    if (result != null) {
      LogD('_filePicker', result.files.single.name +" - "+result.files.single.path!);
      // 将文件名 文件路径存入isra
      IsarHelper.instance.isarInstance.writeTxn(() async {
        BookNovelEntity bookNovelEntity = BookNovelEntity(bookTitle:result.files.single.name,localPath: result.files.single.path!);
        IsarHelper.instance.isarInstance.bookNovelEntitys.put(bookNovelEntity);
      });
    } else {
      // User canceled the picker
    }
  }
}

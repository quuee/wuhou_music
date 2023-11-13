import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/routes/app_routes.dart';

class BookShelfPage extends StatefulWidget {
  const BookShelfPage({super.key});

  @override
  State<BookShelfPage> createState() => _BookShelfPageState();
}

class _BookShelfPageState extends State<BookShelfPage> {

  List<String> bookNames = ['三体','遥远的救世主','三重门','平凡之路','一座城池'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('书架'),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.add))
          ],
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1),
            itemCount: bookNames.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Get.toNamed(Routes.reader);
                },
                child: Text(bookNames[index]),
              );
            }));
  }
}

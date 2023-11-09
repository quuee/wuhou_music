import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wuhoumusic/views/songs_list/songs_list_controller.dart';

class CreateSongListDialog extends StatefulWidget {
  CreateSongListDialog({super.key});

  @override
  State<CreateSongListDialog> createState() => _CreateSongListDialogState();
}

class _CreateSongListDialogState extends State<CreateSongListDialog> {

  final ImagePicker _picker = ImagePicker();

  SongsListController songsListController = Get.find<SongsListController>();

  _chooseImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (songsListController.songListImagePath == null ||
          songsListController.songListImagePath?.trim().compareTo('') == 0) {
        songsListController.songListImagePath =
            (image != null ? image.path : null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageChild;
    if (songsListController.songListImagePath == null ||
        songsListController.songListImagePath?.trim().compareTo('') == 0) {
      imageChild = Container(
        width: 150,
        height: 150,
        child: IconButton(
          onPressed: () async {
            _chooseImage();
          },
          icon: Icon(Icons.add_photo_alternate_outlined),
          iconSize: 60,
        ),
      );
    } else {
      // 判断 网络 本地
      imageChild = Image.file(
        File(songsListController.songListImagePath!),
        width: 150,
        height: 150,
      );
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller: songsListController.songListNameContro,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            child: imageChild,
            onTap: () {
              _chooseImage();
            },
          ),
        ],
      ),
    );
  }
}

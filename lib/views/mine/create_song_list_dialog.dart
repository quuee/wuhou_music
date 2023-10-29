import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wuhoumusic/views/mine/mine_controller.dart';

class CreateSongListDialog extends StatefulWidget {
  CreateSongListDialog({super.key, this.imagePath});
  String? imagePath;
  @override
  State<CreateSongListDialog> createState() => _CreateSongListDialogState();
}

class _CreateSongListDialogState extends State<CreateSongListDialog> {
  final ImagePicker _picker = ImagePicker();

  _chooseImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(widget.imagePath == null || widget.imagePath?.trim().compareTo('') == 0){
        widget.imagePath = (image != null ? image.path : null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MineController mineController = Get.find<MineController>();

    final imageChild;
    if (widget.imagePath == null ||
        widget.imagePath?.trim().compareTo('') == 0) {
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
        File(widget.imagePath!),
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
              controller: mineController.songListNameContro,
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

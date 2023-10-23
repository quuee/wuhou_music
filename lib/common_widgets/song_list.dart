import 'package:flutter/material.dart';
import 'package:wuhoumusic/resource/ali_icons.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/utils/request_client.dart';

class SongList extends StatelessWidget {
  const SongList({super.key});

  /// 底部弹窗
  _showModalBottomSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                    Icons.photo_camera),
                title: Text("Camera"),
                onTap: () async {},
              ),
              ListTile(
                leading: Icon(
                    Icons.photo_library),
                title: Text("Gallery"),
                onTap: () async {},
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(
          vertical: 0, horizontal: 8),
      child: Row(
        children: [
          Image.network(
            '${RequestClient.apiPrefix}/images/wallhaven-wydwyr_2560x1440.png',
            width: 100,
            height: 100,
            errorBuilder: (BuildContext context,Object error,StackTrace? stackTrace){return Image.asset(R.images.logo,width: 100,height: 100,);},
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('印象中的那些歌'),
              Text('共100首'),
            ],
          ),
          Spacer(),
          // PopupMenuButton(itemBuilder: (context){
          //   return [PopupMenuItem(child: Text('menu1'),value: 'menu1',)];
          // })
          IconButton(
              onPressed: () {
                _showModalBottomSheet(context);
              },
              icon: Icon(AliIcons.more))
        ],
      ),
    );
  }
}

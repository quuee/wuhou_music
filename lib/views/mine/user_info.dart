import 'package:flutter/material.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/utils/request_client.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
          "${RequestClient.imagesPrefix}1699103666283_%E5%B7%A6%E8%A5%BF%E5%AE%89%E5%AE%89_-_%E7%89%A1%E4%B8%B9%E4%BA%AD%E5%A4%96.jpg",
          width: 100,
          height: 100, errorBuilder: (c, e, s) {
        return Image.asset(
          R.images.tom,
        );
      }),
    );
  }
}

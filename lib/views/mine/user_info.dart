import 'package:flutter/material.dart';
import 'package:wuhoumusic/resource/r.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
          "https://avatars.githubusercontent.com/u/33923687?v=4",
          width: 100,
          height: 100, errorBuilder: (c, e, s) {
        return Image.asset(
          R.images.tom,
        );
      }),
    );
  }
}

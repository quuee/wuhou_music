import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuhoumusic/utils/request_client.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child:

      CachedNetworkImage(
        height: 100,
        width: 100,
        imageUrl: "${RequestClient.imagesPrefix}tom.jpeg",
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuhoumusic/views/home/tabs/hot_tab_header.dart';

class HotTab extends StatefulWidget {
  const HotTab({super.key});

  @override
  State<HotTab> createState() => _HotTabState();
}

class _HotTabState extends State<HotTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HotTabHeader('最新单曲', () {}),
        buildRecommendSongsList(),
        HotTabHeader('最新音乐', () {}),
        buildSectionSongs(),
      ],
    );
  }
}

buildRecommendSongsList() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Wrap(
      // direction: ,
      spacing: 8,
      children: List<Widget>.generate(7, (index) => buildSongsListItem()),
    ),
  );
}

buildSongsListItem() {
  return InkWell(
    onTap: () {},
    child: Container(
      width: 100,
      child: Column(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: "http://192.168.2.124:9000/images/cat.png",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          Text(
            '她没那么喜欢你，只是刚好遇见你',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          )
        ],
      ),
    ),
  );
}

buildSectionSongs() {
  return Column(
    children: List<Widget>.generate(
        10, (index) => buildSongItem(index, '你的月亮我的心', '曾小贤咸鱼水歌录')),
  );
}

buildSongItem(int index, String songTitle, String songsListTitle) {
  return InkWell(
    onTap: () {},
    child: SizedBox(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Center(child: Text(index.toString()),)
            ),
          ),
          Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    songsListTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {}, icon: Icon(Icons.favorite_border)))
        ],
      ),
    ),
  );
}

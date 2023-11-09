import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingerTab extends StatefulWidget {
  const SingerTab({super.key});

  @override
  State<SingerTab> createState() => _State();
}

class _State extends State<SingerTab> {
  List<String> letters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  List<Map<String, List<String>>> singers = [
    {
      'A': ['阿悄', '阿妹', '阿瓜']
    },
    {
      'B': ['bell', '贝吉塔']
    },
    {
      'C': ['陈奕迅', '陈冠希']
    },
    {
      'D': ['大表姐', '大舌头']
    },
    {
      'E': ['伊莲', '伊人组合']
    },
    {
      'F': ['佛说', '费玉清']
    },
    {
      'G': ['郭静', '郭京飞']
    },
    {
      'H': ['郭静', '郭京飞']
    }
  ]; // 数据结构需要包两层，外层字母为key，内层为值

  ScrollController _scrollContr = ScrollController();

  int _currentIndex = 0;

  _buildOnTaoJump(String word, int index) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.greenAccent : Color(0xffb8e6b9),
            borderRadius: BorderRadius.circular(22)),
        child: Text(
          word,
          style: TextStyle(fontSize: 14),
        ),
      ),
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        double height = index * 45.0; // 多少个 左侧字母的高度
        for (int i = 0; i < index; i++) {
          height += singers[i].entries.first.value.length * 46; //多少个实际数据的高度
        }
        _scrollContr.jumpTo(height);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 左侧歌手
        Padding(
            padding: EdgeInsets.only(left: 20),
            child: ListView.builder(
                // 第一层 字母
                controller: _scrollContr,
                itemCount: singers.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 45,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(singers[index].entries.first.key),
                        ),
                      ),
                      ListView.builder(
                          //第二层 名字
                          shrinkWrap: true, // 多层嵌套滚动必须加shrinkWrap: true
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: singers[index].entries.first.value.length,
                          itemBuilder: (context, index2) {
                            return Container(
                              height: 46,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          "http://192.168.2.124:9000/images/cat.png",
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    Text(singers[index]
                                        .entries
                                        .first
                                        .value[index2])
                                  ],
                                ),
                              ),
                            );
                          })
                    ],
                  );
                })),
        //右侧固定导航字母
        Align(
          alignment: FractionalOffset(1.0, 0.5),
          // FractionalOffset(0.0, 0.0)：顶部左边
          // FractionalOffset(0.5, 0.0)：顶部中间
          // FractionalOffset(1.0, 0.0)：顶部右边
          // FractionalOffset(0.0, 0.5)：中部左边
          // FractionalOffset(0.5, 0.5)：中部中间
          // FractionalOffset(1.0, 0.5)：中部右边
          // FractionalOffset(0.0, 1.0)：底部左边
          // FractionalOffset(0.5, 1.0)：底部中间
          // FractionalOffset(1.0, 1.0)：底部右边
          child: SizedBox(
            width: 25,
            child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: ListView.builder(
                    itemCount: letters.length,
                    itemBuilder: (c, index) {
                      return _buildOnTaoJump(letters[index], index);
                    })),
          ),
        )
        // 右侧字母索引
      ],
    );
  }
}

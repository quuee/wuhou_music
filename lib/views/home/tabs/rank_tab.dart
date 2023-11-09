import 'package:flutter/material.dart';
import 'package:wuhoumusic/common_widgets/marquee.dart';

class RankTab extends StatefulWidget {
  const RankTab({super.key});

  @override
  State<RankTab> createState() => _RankTabState();
}

class _RankTabState extends State<RankTab>  with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Marquee(mText:'跑马灯测试数据1',orientation: MarqueeOrientation.vertical,speed: 0.5,),
          Marquee(mText:'跑马灯测试数据2',orientation: MarqueeOrientation.horizontal,speed: 1,),
        ],
      )
    );
  }

}


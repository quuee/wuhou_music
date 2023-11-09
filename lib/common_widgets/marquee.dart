
import 'package:flutter/material.dart';

enum MarqueeOrientation {
  horizontal,
  vertical,
}

class Marquee extends StatefulWidget {
  Marquee({super.key,this.mText,this.orientation = MarqueeOrientation.horizontal,this.speed = 0.5});

  String? mText;// 展示的文字
  MarqueeOrientation orientation; //方向: 横向(左 <- 右)，垂直(下到上)
  double speed;// speed是我们定义的偏移速度

  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> with SingleTickerProviderStateMixin {

  late double width;

  late double height;

  late TextSpan measureText;

  late _TextInfo textInfo;

  late TextPainter _painter;

  late AnimationController _scrollController;

  final double kMargin = 10.0;


  @override
  void initState() {
    super.initState();
    measureText =
        TextSpan(text: widget.mText, style: const TextStyle(color: Colors.black));

    _painter = TextPainter(
      text: measureText,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(minWidth: 0.0, maxWidth: double.infinity);

    _scrollController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    width = _painter.width;
    height = _painter.height;
    textInfo = _TextInfo(width, height, kMargin);
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.repeat();
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (_scrollController.isAnimating) _scrollController.stop();
    if (!_scrollController.isAnimating) _scrollController.repeat();
  }

  @override
  void dispose() {
    if (_scrollController.isAnimating) {
      _scrollController.stop();
    }
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(builder: (_, constraints) {
        return ClipRect(
          clipBehavior: Clip.hardEdge,
          child: CustomPaint(
            size: Size(constraints.maxWidth, height),
            painter: _RevolvingLanternPainter(_painter, textInfo,widget.orientation),
          ),
        );
      }),
    );
  }

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  void _scrollListener() {
    if(widget.orientation == MarqueeOrientation.horizontal){
      textInfo.updateHorizontal(widget.speed);
    }
    if(widget.orientation == MarqueeOrientation.vertical){
      textInfo.updateVertical(widget.speed);
    }
  }
}

// 这里继承里ChangeNotifier, 可以让我们以最小的代价刷新界面
class _TextInfo extends ChangeNotifier {
  // 绘制时最前面的文字偏移
  double head = 0.0;

  double width;

  double height;

  double margin;

  _TextInfo(this.width, this.height, this.margin);

  // 水平
  void updateHorizontal(double speed) {
    // head从右侧开始为起点
    head -= speed;
    // 如果超过了文字大小和间距的总长度,说明当前的文字已经超出了屏幕.
    // 我们应该用紧接着下一条数据的偏移量赋值
    if (head < -width - margin) {
      head += width + margin; // 加回去又重起点开始
    }
    notifyListeners();
  }

  // 垂直
  void updateVertical(double speed) {
    // head从底部开始为起点
    head -= speed;
    // 如果超过了文字大小和间距的总高度,说明当前的文字已经超出了屏幕.
    // 我们应该用紧接着下一条数据的偏移量赋值
    if (head < -height - margin) {
      head += height + margin; // 加回去又重起点开始
    }
    notifyListeners();
  }
}

class _RevolvingLanternPainter extends CustomPainter {
  TextPainter painter;

  _TextInfo textInfo;

  MarqueeOrientation _orientation; //方向: 横向(左 <- 右)，垂直(下到上)

  _RevolvingLanternPainter(
      this.painter,
      this.textInfo,
      this._orientation,
      ) : super(repaint: textInfo);

  @override
  void paint(Canvas canvas, Size size) {
    double x = textInfo.head;
    if(this._orientation == MarqueeOrientation.horizontal){
      while (x < size.width) { // 如果x（偏移量）大于界面的尺寸就不会绘制
        painter.paint(canvas, Offset(x, 0.0)); // 水平
        x += textInfo.width + textInfo.margin;
      }
    }
    if(this._orientation == MarqueeOrientation.vertical){
      while (x < size.height) { // 如果x（偏移量）大于界面的尺寸就不会绘制
        painter.paint(canvas, Offset(0.0, x)); // 垂直
        x += textInfo.height + textInfo.margin;
      }
    }

  }

  @override
  bool shouldRepaint(_RevolvingLanternPainter oldDelegate) {
    return textInfo != oldDelegate.textInfo;
  }
}

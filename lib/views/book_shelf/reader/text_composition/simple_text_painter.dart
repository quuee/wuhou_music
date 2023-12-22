import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wuhoumusic/views/book_shelf/reader/read_controller.dart';

class SimpleTextPainter extends CustomPainter {
  final TextPage textPage;
  final int pageIndex;

  ui.Image? backgroundImage;
  double fontSize;
  double fontHeight;
  Color fontColor = const Color(0xFF303133);

  SimpleTextPainter(
      {required this.textPage,
      required this.pageIndex,
      this.backgroundImage,
      required this.fontSize,
      required this.fontHeight});

  @override
  void paint(Canvas canvas, Size size) {
    var picture = getPicture(size);
    canvas.drawPicture(picture!);
  }

  @override
  bool shouldRepaint(SimpleTextPainter oldDelegate) {
    return oldDelegate.pageIndex != pageIndex;
  }

  _paintText(ui.Canvas canvas, ui.Size size, TextPage page) {

    final lineCount = page.lines.length;
    final tp = TextPainter(textDirection: TextDirection.ltr, maxLines: 1);
    final titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize + 2,
      // fontFamily: config.fontFamily,
      color: fontColor,
      height: fontHeight,
    );
    final style = TextStyle(
      fontSize: fontSize,
      // fontFamily: config.fontFamily,
      color: fontColor,
      height: fontHeight,
    );

    for (var i = 0; i < lineCount; i++) {
      final line = page.lines[i];
      if (line.letterSpacing != null &&
          (line.letterSpacing! < -0.1 || line.letterSpacing! > 0.1)) {
        tp.text = TextSpan(
          text: line.text,
          style: line.isTitle
              ? TextStyle(
                  letterSpacing: line.letterSpacing,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize + 2,
                  // fontFamily: config.fontFamily,
                  color: fontColor,
                  height: fontHeight,
                )
              : TextStyle(
                  letterSpacing: line.letterSpacing,
                  fontSize: fontSize,
                  // fontFamily: fontFamily,
                  color: fontColor,
                  height: fontHeight,
                ),
        );
      } else {
        tp.text =
            TextSpan(text: line.text, style: line.isTitle ? titleStyle : style);
      }
      final offset = Offset(line.dx, line.dy);
      tp.layout();
      tp.paint(canvas, offset);

      // final _lineHeight = fontSize * fontHeight;
      // canvas.drawLine(
      //     Offset(line.dx, line.dy + _lineHeight),
      //     Offset(line.dx + page.column, line.dy + _lineHeight),
      //     Paint()..color = Colors.grey);
    }
  }

  ui.Picture? getPicture(Size size) {
    // final textPage = textPages[index];
    final pic = ui.PictureRecorder();
    final c = Canvas(pic);
    final pageRect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    c.drawRect(pageRect, Paint()..color = Color(0xFFFFFFCC));
    if (backgroundImage != null) {
      c.drawImage(backgroundImage!, Offset.zero, Paint());
    }
    _paintText(c, size, textPage);
    return pic.endRecording();
  }
}

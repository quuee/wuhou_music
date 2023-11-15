import 'package:logger/logger.dart';

const String _defaultTag = "LoggerTag";

var _logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: false),
  output: null
);

LogT(String? tag, String msg) {
  tag ??= _defaultTag;
  _logger.t("$tag :: $msg");
}

LogD(String? tag, String msg) {
  tag ??= _defaultTag;
  _logger.d("$tag :: $msg");
}

LogI(String? tag, String msg) {
  tag ??= _defaultTag;
  _logger.i("$tag :: $msg");
}

LogW(String? tag, String msg) {
  tag ??= _defaultTag;
  _logger.w("$tag :: $msg");
}

LogE(String? tag, String msg) {
  tag ??= _defaultTag;
  _logger.e("$tag :: $msg");
}

LogF(String? tag, String msg) {
  tag ??= _defaultTag;
  _logger.f("$tag :: $msg");
}

import 'gbk.dart';
import 'unicode.dart';
import 'dart:convert';

/// https://github.com/best-flutter/gbk2utf8.git
class CodeConvertUtil {

  static String gbk2utf8(List<int> bytes){
    List<int> gbkun = gbk2unicode(bytes);
    List<int> utf8un = unicode2utf8(gbkun);
    return utf8.decode(utf8un);
  }
  /// gbk => unicode word array
  /// @param gbk_buf byte array
  /// @return   word array
  static List<int> gbk2unicode(List<int> gbkBuf) {
    int uniInd = 0, gbkInd = 0, uniNum = 0;
    int ch;
    int word; //unsigned short
    int wordPos;
    List<int> uniPtr = List.generate(gbkBuf.length, (index) => 0);

    for (; gbkInd < gbkBuf.length;) {
      ch = gbkBuf[gbkInd];
      if (ch > 0x80) {
        word = gbkBuf[gbkInd];
        word <<= 8;
        word += gbkBuf[gbkInd + 1];
        gbkInd += 2;
        wordPos = word - gbk_first_code;
        if (word >= gbk_first_code &&
            word <= gbk_last_code &&
            (wordPos < unicode_buf_size)) {
          uniPtr[uniInd] = unicodeTables[wordPos];
          uniInd++;
          uniNum++;
        }
      } else {
        gbkInd++;
        uniPtr[uniInd] = ch;
        uniInd++;
        uniNum++;
      }
    }

    uniPtr.length = uniNum;

    return uniPtr;
  }

  ///Word array to utf-8
  static List<int> unicode2utf8(List<int> wordArray) {
    // a utf-8 character is 3 bytes
    List<int> list = List.generate(wordArray.length * 3, (index) => 0);
    int pos = 0;

    for (int i = 0, c = wordArray.length; i < c; ++i) {
      int word = wordArray[i];
      if (word <= 0x7f) {
        list[pos++] = word;
      } else if (word >= 0x80 && word <= 0x7ff) {
        list[pos++] = 0xc0 | ((word >> 6) & 0x1f);
        list[pos++] = 0x80 | (word & 0x3f);
      } else if (word >= 0x800 && word < 0xffff) {
        list[pos++] = 0xe0 | ((word >> 12) & 0x0f);
        list[pos++] = 0x80 | ((word >> 6) & 0x3f);
        list[pos++] = 0x80 | (word & 0x3f);
      } else {
        //-1
        list[pos++] = -1;
      }
    }

    list.length = pos;
    return list;
  }

  static int z_pos(int x) {
    for (int i = 0; i < 5; i++, x <<= 1) {
      if ((x & 0x80) == 0) return i;
    }

    return 4;
  }

  static List<int> mask = [0x7f, 0x3f, 0x1f, 0x0f, 0x7];

  static List<int> utf82unicode(List<int> bytes) {
    List<int> loc = [];

    for (int i = 0; i < bytes.length;) {
      int byte_cnt = z_pos(bytes[i]);
      int sum = bytes[i] & mask[byte_cnt];

      for (int j = 1; j < byte_cnt; j++) {
        sum <<= 6;
        sum |= bytes[i + j] & mask[1];
      }

      i += byte_cnt > 0 ? byte_cnt : 1;
      loc.add(sum);
    }

    return loc;
  }
}
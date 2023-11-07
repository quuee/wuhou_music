import 'dart:convert';

class ApiResult {
  int? code;
  String? msg;
  dynamic data;

  ApiResult({this.code, this.msg, this.data});

  ApiResult.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    return {"code": code, "msg": msg, "data": data};
  }

  String toRaw(Map<String, dynamic> map) {
    return jsonEncode(map);
  }
}

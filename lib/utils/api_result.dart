
class ApiResult {
  int? code;
  String? msg;
  Map<String,dynamic>? data;

  ApiResult({this.code, this.msg, this.data});

  ApiResult.fromJson(
      Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }



}

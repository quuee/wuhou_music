import 'dart:convert';

List<UserEntity> userEntityFromJson(String str) => List<UserEntity>.from(json.decode(str).map((x) => UserEntity.fromJson(x)));
String userEntityToJson(List<UserEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserEntity {
  String whuid;
  String accountName;
  String? nickName;
  String? avatarUrl;
  String? birthday;
  String? phoneNumber;
  String? email;


  UserEntity({
    required this.whuid,
    required this.accountName,
    this.nickName,
    this.avatarUrl,
    this.birthday,
    this.phoneNumber,
    this.email,
  });

  factory UserEntity.fromRawJson(String str) => UserEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    whuid: json["whuid"],
    accountName: json["accountName"],
    nickName: json["nickName"],
    avatarUrl: json["avatarUrl"],
    birthday: json["birthday"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "whuid": whuid,
    "accountName": accountName,
    "nickName": nickName,
    "avatarUrl": avatarUrl,
    "birthday": birthday,
    "phoneNumber": phoneNumber,
    "email": email,
  };
}
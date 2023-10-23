import 'dart:convert';

List<UserEntity> userEntityFromJson(String str) => List<UserEntity>.from(json.decode(str).map((x) => UserEntity.fromJson(x)));
String userEntityToJson(List<UserEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserEntity {
  int? userId;
  String? username;
  int? age;

  UserEntity({
    this.userId,
    this.username,
    this.age,
  });

  factory UserEntity.fromRawJson(String str) => UserEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    userId: json["userId"],
    username: json["username"],
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "age": age,
  };
}
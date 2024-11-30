// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

import 'package:talents/Modules/Auth/Model/user.dart';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

class ProfileResponse {
  final User data;
  final int code;

  ProfileResponse({
    required this.data,
    required this.code,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        data: User.fromJson(json["data"]),
        code: json["code"],
      );
}

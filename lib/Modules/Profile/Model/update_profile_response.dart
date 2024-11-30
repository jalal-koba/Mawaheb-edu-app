import 'package:talents/Modules/Auth/Model/user.dart';

class UpdateProfileResponse {
  final User data;
  final int code;

  UpdateProfileResponse({
    required this.data,
    required this.code,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponse(
        data: User.fromJson(json["data"]),
        code: json["code"],
      );
}

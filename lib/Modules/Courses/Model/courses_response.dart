import 'package:talents/Modules/Courses/Model/course.dart';

class CoursesResponse {
  final Data data;
  final int code;

  CoursesResponse({
    required this.data,
    required this.code,
  });

  factory CoursesResponse.fromJson(Map<String, dynamic> json) =>
      CoursesResponse(
        data: Data.fromJson(json["data"]),
        code: json["code"],
      );
}

class Data {
  final int currentPage;
  final List<Course> data;

  Data({
    required this.currentPage,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Course>.from(json["data"].map((x) => Course.fromJson(x))),
      );
}

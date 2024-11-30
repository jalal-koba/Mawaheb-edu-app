import 'package:talents/Modules/Courses/Model/course.dart'; 
import 'package:talents/Modules/Payments_Orders/Model/section.dart';

class OneSectionResponse {
  final Data data;
  final int code;
  final Section parentSection;

  OneSectionResponse({
    required this.data,
    required this.code,
    required this.parentSection,
  });

  factory OneSectionResponse.fromJson(Map<String, dynamic> json) =>
      OneSectionResponse(
        data: Data.fromJson(json["data"]),
        code: json["code"],
        parentSection: Section.fromJson(json["parent_section"]),
      );
}

class Data {
  final int currentPage;
  final List<Course> data;
  final dynamic nextPageUrl;
  final String path;

  final int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.nextPageUrl,
    required this.path,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Course>.from(json["data"].map((x) => Course.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        total: json["total"],
      );
}

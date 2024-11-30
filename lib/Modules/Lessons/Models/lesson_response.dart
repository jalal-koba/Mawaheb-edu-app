import 'package:talents/Modules/Lessons/Models/lesson.dart';

class LessonResponse {
  final Lesson data;
  final int code;

  LessonResponse({
    required this.data,
    required this.code,
  });

  factory LessonResponse.fromJson(Map<String, dynamic> json) => LessonResponse(
        data: Lesson.fromJson(json["data"]),
        code: json["code"],
      );
}

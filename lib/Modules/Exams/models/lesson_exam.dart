
import 'package:talents/Modules/lessons/models/lesson.dart';

 

LessonExam lessonExamFromJson(Map<String, dynamic> str) => LessonExam.fromJson(str);

 
class LessonExam {
  final Lesson data;
  final int code;

  LessonExam({
    required this.data,
    required this.code,
  });

  factory LessonExam.fromJson(Map<String, dynamic> json) =>
      LessonExam(
        data: Lesson.fromJson(json["data"]),
        code: json["code"],
      );

  
}
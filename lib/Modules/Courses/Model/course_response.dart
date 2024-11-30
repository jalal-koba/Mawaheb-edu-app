import 'package:talents/Modules/Courses/Model/parent_section.dart';
import 'package:talents/Modules/Lessons/Models/lesson.dart';

class CourseInfoResponse {
  final Data? data;

  final ParentSection parentSection;
  final int? finalExamId;
  final bool canSolveFinalExam;
  final bool canApplyForCertificate;
  final List<Lesson> lessons;
  final Certificate? certificate;

  CourseInfoResponse({
    required this.data,
    required this.lessons,
    required this.parentSection,
    required this.certificate,
    required this.finalExamId,
    required this.canSolveFinalExam,
    required this.canApplyForCertificate,
  });

  factory CourseInfoResponse.fromJson(Map<String, dynamic> json) {
    if (json["data"] is Map<String, dynamic>) {
      return CourseInfoResponse(
        lessons: [],
        data: Data.fromJson(json["data"]),
        certificate: json["certificate"] != null
            ? Certificate.fromJson(json["certificate"])
            : null,
        parentSection: ParentSection.fromJson(json["parent_section"]),
        finalExamId: json["final_exam_id"],
        canSolveFinalExam: json["can_solve_final_exam"] ?? false,
        canApplyForCertificate: json["can_apply_for_certificate"] ?? false,
      );
    } else {
      return CourseInfoResponse(
        lessons: List<Lesson>.from(json["data"].map((x) => Lesson.fromJson(x))),
        data: null,
        parentSection: ParentSection.fromJson(json["parent_section"]),
        finalExamId: json["final_exam_id"],
        certificate: json["certificate"] != null
            ? Certificate.fromJson(json["certificate"])
            : null,
        canSolveFinalExam: json["can_solve_final_exam"] ?? false,
        canApplyForCertificate: json["can_apply_for_certificate"] ?? false,
      );
    }
  }
}

class Data {
  final List<Lesson> freeLessons;
  final List<Lesson> paidLessons;

  Data({
    required this.paidLessons,
    required this.freeLessons,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        freeLessons: json["free_lessons"] != null
            ? List<Lesson>.from(
                json["free_lessons"].map((x) => Lesson.fromJson(x)))
            : [],
        paidLessons: json["paid_lessons"] != null
            ? List<Lesson>.from(
                json["paid_lessons"].map((x) => Lesson.fromJson(x)))
            : [],
      );
}

class Certificate {
  final String status;
  final String? file, note;
  Certificate({
    required this.status,
    required this.file,
    required this.note,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        status: json["status"],
        file: json["file"],
        note: json["note"],
      );
}

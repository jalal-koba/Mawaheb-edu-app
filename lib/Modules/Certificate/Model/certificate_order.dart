import 'package:talents/Modules/Courses/Model/course.dart';

class CertificateOrder {
  final int id;
  final int studentId;
  final String status;
  final dynamic file;
  final Course course;
  final dynamic rejectedAt;
  final dynamic acceptedAt;
  final dynamic note;
  final dynamic deletedAt;
  final dynamic cereatedAt;

  CertificateOrder({
    required this.id,
    required this.studentId,
    required this.status,
    required this.file,
    required this.course,
    required this.rejectedAt,
    required this.acceptedAt,
    required this.cereatedAt,
    required this.note,
    required this.deletedAt,
  });

  factory CertificateOrder.fromJson(Map<String, dynamic> json) =>
      CertificateOrder(
        cereatedAt: json['created_at'],
        id: json["id"],
        studentId: json["student_id"],
        status: json["status"],
        file: json["file"],
        course: Course.fromJson(json["course"]),
        rejectedAt: json["rejected_at"],
        acceptedAt: json["accepted_at"],
        note: json["note"],
        deletedAt: json["deleted_at"],
      );
}

import 'package:talents/Modules/Courses/Model/course.dart';

class Trainer {
  final int id;
  final String fullName;
  final String username;
  final String? description;
  // final String email;
  // final String phoneNumber; 
  final int isHidden;
  final String? image;
  final List<Course> courses;

  Trainer({
    required this.id,
    required this.fullName,
    required this.username,
    required this.description,
    // required this.email,
    // required this.phoneNumber, 
    required this.isHidden,
    required this.image,
    required this.courses,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
        id: json["id"],
        fullName: json["full_name"] ?? "",
        username: json["username"],
        description: json["description"],
        // email: json["email"],
        // phoneNumber: json["phone_number"], 
        isHidden: json["is_hidden"],
        image: json["image"],
        courses: json["courses"] != null
            ? List<Course>.from(json["courses"].map((x) => Trainer.fromJson(x)))
            : [],
      );
}

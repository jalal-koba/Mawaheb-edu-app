import 'package:talents/Modules/Trainers/Model/trainer.dart';
import 'package:talents/Modules/Utils/bool_converter.dart';

class ParentSection {
  final int id;
  final dynamic parentId;

  final String name;
  final String image;
  final String description;
  final num? discount;
  final dynamic teachers;
  final dynamic subscribed;
  final num price;
  final String? introVideo;
  final dynamic totalLessonsTime;
  final bool isFree;

  ParentSection({
    required this.id,
    required this.price,
    required this.introVideo,
    required this.discount,
    required this.isFree,
    required this.parentId,
    required this.name,
    required this.image,
    required this.description,
    required this.teachers,
    required this.subscribed,
    required this.totalLessonsTime,
  });

  factory ParentSection.fromJson(Map<String, dynamic> json) => ParentSection(
        id: json["id"],
        parentId: json["parent_id"],
        discount: json['discount'],
        price: json["price"],
        introVideo: json["intro_video"],
        isFree: boolConverter(json["is_free"]),
        name: json["name"],
        image: json["image"],
        description: json["description"],
        teachers: json["teachers"] != null
            ? List<Trainer>.from(
                json["teachers"].map((x) => Trainer.fromJson(x)))
            : [],
        subscribed: json["subscribed"],
        totalLessonsTime: json["total_lessons_time"],
      );
}

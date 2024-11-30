import 'package:talents/Modules/Courses/Model/course.dart';
import 'package:talents/Modules/Library/Model/library.dart';
import 'package:talents/Modules/Offers/Models/offer.dart';
import 'package:talents/Modules/Payments_Orders/Model/section.dart';
import 'package:talents/Modules/Trainers/Model/trainer.dart';
 
class HomeResponse {
  final Home data;
  final int code;

  HomeResponse({
    required this.data,
    required this.code,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        data: Home.fromJson(json["data"]),
        code: json["code"],
      );
}

class Home {
  final Instructors instructors;
  final Sections sections;
  final Offers offers;
  final Courses courses;
  final Library dataLibrary;
  final String ownerInfo;
   Home({
    required this.instructors,
     required this.ownerInfo,
    required this.sections,
    required this.offers,
    required this.courses,
    required this.dataLibrary,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
      instructors: Instructors.fromJson(json["instructors"]),
      sections: Sections.fromJson(json["sections"]),
      offers: Offers.fromJson(json["offers"]),
      courses: Courses.fromJson(json["courses"]),
      dataLibrary: Library.fromJson(json["library"]),
      ownerInfo: json['cash']['info'] ?? "",
       );
}

class Courses {
  final List<Course> data;

  Courses({
    required this.data,
  });

  factory Courses.fromJson(Map<String, dynamic> json) => Courses(
        data: List<Course>.from(json["data"].map((x) => Course.fromJson(x))),
      );
}

class Instructors {
  final List<Trainer> data;

  Instructors({
    required this.data,
  });

  factory Instructors.fromJson(Map<String, dynamic> json) => Instructors(
        data: json["data"] != null
            ? List<Trainer>.from(json["data"].map((x) => Trainer.fromJson(x)))
            : [],
      );
}

class Offers {
  final List<Offer> data;

  Offers({
    required this.data,
  });

  factory Offers.fromJson(Map<String, dynamic> json) => Offers(
        data: List<Offer>.from(json["data"].map((x) => Offer.fromJson(x))),
      );
}

class Sections {
  final List<Section> data;

  Sections({
    required this.data,
  });

  factory Sections.fromJson(Map<String, dynamic> json) => Sections(
        data: List<Section>.from(json["data"].map((x) => Section.fromJson(x))),
      );
}

import 'option.dart';

class Question {
  final int id;
  final String text;
  final int degree;
  final String? note;
  final List<Option> options;
  final dynamic deletedAt;

  Question({
    required this.id,
    required this.text,
    required this.degree,
    required this.note,
    required this.options,
    required this.deletedAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    text: json["text"],
    degree: json["degree"],
    note: json["note"]  ,
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "degree": degree,
    "note": note,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
    "deleted_at": deletedAt,
  };
}
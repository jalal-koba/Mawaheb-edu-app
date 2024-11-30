import 'package:talents/Modules/Utils/bool_converter.dart';

import 'result.dart';
import 'question.dart';

class Exam {
  final int id;
  final String description;
  final num minutes;
  final num? remainingTime;
  final int passPercentage;
  final List<Question> questions;
  final Result? result;
  final bool isSolving;

  Exam({
    required this.id,
    required this.minutes,
    required this.isSolving,
    required this.description,
    required this.remainingTime,
    required this.passPercentage,
    required this.questions,
    required this.result,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        description: json["description"] ?? '',
        minutes: json["minutes"],
        remainingTime: json["remaining_time"],
        isSolving: boolConverter(json["is_solving"]),
        passPercentage: json["pass_percentage"] ?? 0,
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x))),
        result: Result.fromJson(json["result"]),
      );
}

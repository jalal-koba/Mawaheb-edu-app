class Result {
  final bool? pass;
  final int? passPercentage;
  final double? studentPercentage;
  final int? totalDegree;
  final int? studentDegree;

  Result({
    required this.pass,
    required this.passPercentage,
    required this.studentPercentage,
    required this.totalDegree,
    required this.studentDegree,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        pass: json["pass"],
        passPercentage: json["pass_percentage"],
        studentPercentage: json["student_percentage"] == null
            ? null
            : double.parse(json["student_percentage"].toString()),
        totalDegree: json["total_degree"],
        studentDegree: json["student_degree"],
      );
 
}

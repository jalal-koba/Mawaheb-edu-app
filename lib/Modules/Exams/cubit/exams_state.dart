import 'package:flutter/material.dart';
import 'package:talents/Modules/Exams/models/exam.dart';

@immutable
abstract class ExamsState {}

class ExamsInitState extends ExamsState {}

class GetExamsLoadingState extends ExamsState {}

class GetExamsSuccessState extends ExamsState {}

class GetExamsErrorState extends ExamsState {
  final String message;

  GetExamsErrorState({
    required this.message,
  });
}

class StartExamLoadingState extends ExamsState {}

class StartExamSuccessState extends ExamsState {}

class StartExamErrorState extends ExamsState {
  final String message;
  final bool isSolved;
  StartExamErrorState({required this.message, this.isSolved = false});
}

class SubmitExamLoadingState extends ExamsState {}

class SubmitExamSuccessState extends ExamsState {
  final Exam? exam;
  final String? message;
  final dynamic  result;

  final bool success;
  SubmitExamSuccessState(
      {this.result, this.exam, required this.success, this.message});
}

class SubmitExamErrorState extends ExamsState {
  final String message;

  SubmitExamErrorState({
    required this.message,
  });
}
//

class OpenNextLessonLoadingState extends ExamsState {}

class OpenNextLessonSuccessState extends ExamsState {
  final int nextLessonId;

  OpenNextLessonSuccessState({required this.nextLessonId});
}

class OpenNextLessonErrorState extends ExamsState {
  final String message;
  OpenNextLessonErrorState({required this.message});
}

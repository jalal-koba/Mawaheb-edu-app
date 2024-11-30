abstract class LessonState {}

final class LessonInitialState extends LessonState {}

final class ShowingTestResultState extends LessonState {}

final class GetCertificateState extends LessonState {}

final class GetLessonLoadingState extends LessonState {}

final class GetLessonSuccessState extends LessonState {}

final class GetLessonErrorState extends LessonState {
  final String message;

  GetLessonErrorState({required this.message});
}

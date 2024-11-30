abstract class CourseState {}

final class CourseInitialState extends CourseState {}

final class AddImageState extends CourseState {}

final class RemoveImageState extends CourseState {}

final class CourseLoadingState extends CourseState {}

final class CourseSuccessState extends CourseState {}

final class CourseErrorState extends CourseState {
  final String message;
  CourseErrorState({
    required this.message,
  });
}

final class SearchCourseLoading extends CourseState {}

final class SearchCourseSuccess extends CourseState {}

final class SearchCourseError extends CourseState {
  final String message;
  SearchCourseError({
    required this.message,
  });
}

//
final class SubscribedCourseLoadingState extends CourseState {}

final class SubscribedCourseSuccessState extends CourseState {}

final class SubscribedCourseErrorState extends CourseState {
  final String message;
  SubscribedCourseErrorState({
    required this.message,
  });
}

//

final class SubscribeInCourseLoadingState extends CourseState {}

final class SubscribeInCourseSuccessState extends CourseState {}

final class SubscribeInCourseErrorState extends CourseState {
  final String message;
  SubscribeInCourseErrorState({
    required this.message,
  });
}

///
final class LatestCoursesLoadingState extends CourseState {}

final class LatestCoursesSuccessState extends CourseState {}

final class LatestCoursesErrorState extends CourseState {
  final String message;
  LatestCoursesErrorState({
    required this.message,
  });
}

//

final class BuyCourseLoadingState extends CourseState {}

final class BuyCourseSuccessState extends CourseState {}

final class BuyCourseErrorState extends CourseState {
  final String message;
  BuyCourseErrorState({
    required this.message,
  });
}

//
final class CheckCuponLoadingState extends CourseState {}

final class CheckCuponSuccessState extends CourseState {
  final bool discountSuccess;
  final String? errorMessage;

  CheckCuponSuccessState({
    required this.discountSuccess,
    this.errorMessage,
  });
}

final class CheckCuponErrorState extends CourseState {
  final String message;
  CheckCuponErrorState({
    required this.message,
  });
}

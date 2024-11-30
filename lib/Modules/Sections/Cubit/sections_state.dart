abstract class SectionsState {}

final class SectionsInitialState extends SectionsState {}

final class SectionsLoadingState extends SectionsState {}

final class SectionsSuccessState extends SectionsState {}

final class SectionsErrorState extends SectionsState {
  SectionsErrorState({required this.message, this.code = 0});
  String message;
  int code;
}
////////

final class OneSectionLoadingState extends SectionsState {}

final class OneSectionSuccessState extends SectionsState {}

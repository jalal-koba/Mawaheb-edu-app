abstract class LibraryState {}

final class LibraryInitialState extends LibraryState {}

final class LibraryLoadingState extends LibraryState {}

final class LibrarySuccessState extends LibraryState {}

final class LibraryErrorState extends LibraryState {
  LibraryErrorState({required this.message});
  String message;
}

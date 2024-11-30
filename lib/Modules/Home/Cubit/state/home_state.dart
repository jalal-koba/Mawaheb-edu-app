abstract class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeSuccessState extends HomeState {}

final class HomeErrorState extends HomeState {
  HomeErrorState({required this.message});
  String message;
}

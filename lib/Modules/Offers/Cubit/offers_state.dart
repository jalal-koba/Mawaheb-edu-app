abstract class OffersState {}

final class OffersInitialState extends OffersState {}

final class OffersLoadingState extends OffersState {}

final class OffersSuccessState extends OffersState {}

final class OffersErrorState extends OffersState {
  OffersErrorState({required this.message});
  String message;
}

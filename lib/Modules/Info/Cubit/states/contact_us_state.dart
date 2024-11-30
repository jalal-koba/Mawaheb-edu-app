abstract class InfoState {}

final class InfoInitialState extends InfoState {}

final class InfoLoadingState extends InfoState {}

final class InfoSuccessState extends InfoState {}

final class InfoErrorState extends InfoState {
  InfoErrorState({required this.message});
  String message;
}

final class SendMessageLoadingState extends InfoState {}

final class SendMessageSuccessState extends InfoState {}

final class SendMessageErrorState extends InfoState {
  SendMessageErrorState({required this.message});
  String message;
}

abstract class TrainerState {}

final class TrainerInitialState extends TrainerState {}

final class TrainerLoadingState extends TrainerState {}

final class TrainerSuccessState extends TrainerState {}

final class TrainerErrorState extends TrainerState {
  TrainerErrorState({required this.message});
  String message;
}

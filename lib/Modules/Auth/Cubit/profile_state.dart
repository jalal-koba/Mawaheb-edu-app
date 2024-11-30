abstract class ProfileState {}

final class ProfileInitialState extends ProfileState {}

final class UnAuthenticatedState extends ProfileState {}

final class PasswordEditingState extends ProfileState {}

final class PasswordSavingState extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

//////////////////////

final class ProfileEditingStart extends ProfileState {}

final class ProfileEditingLoadingState extends ProfileState {}

final class ProfileEditingSuccessState extends ProfileState {}

final class ProfileSucscssState extends ProfileState {}

final class ProfileEditingErrorState extends ProfileState {
  final String message;

  ProfileEditingErrorState({required this.message});
}

final class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState({required this.message});
}
///////////////////


///
  

 
part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthCubitInitial extends AuthState {}

final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class LoginErrorState extends AuthState {
  LoginErrorState({required this.message});
  final String? message;
}

//

final class SiginUpLoadingState extends AuthState {}

final class SiginUpSuccessState extends AuthState {}

final class SiginUpErrorState extends AuthState {
  SiginUpErrorState({required this.message});
  final String? message;
}

//

final class LogoutLoadingState extends AuthState {}

final class LogoutSuccessState extends AuthState {}

final class LogoutErrorState extends AuthState {
  LogoutErrorState({required this.message, this.code = 0});
  final String message;
  final int code;
}
//

final class GetCodeLoadingState extends AuthState {}

final class GetCodeSuccessState extends AuthState {}

final class GetCodeErrorState extends AuthState {
  GetCodeErrorState({required this.message});
  final String message;
}

final class CheckCodeLoadingState extends AuthState {}

final class CheckCodeSuccessState extends AuthState {
  CheckCodeSuccessState({required this.isValid});
  final bool isValid;
}

final class CheckCodeErrorState extends AuthState {
  CheckCodeErrorState({required this.message});
  final String message;
}
//

final class ResetPasswordLoadingState extends AuthState {}

final class ResetPasswordSuccessState extends AuthState {}

final class RestPasswordErrorState extends AuthState {
  RestPasswordErrorState({required this.message});
  final String? message;
}

//

final class ChangeVerifiedEmailState extends AuthState {}

final class ChangePasswordInitialState extends AuthState {}

final class ChangePasswordLoadingState extends AuthState {}

final class ChangePasswordSuccessState extends AuthState {}

final class ChangePasswordErrorState extends AuthState {
  ChangePasswordErrorState({required this.message});
  final String message;
}

final class ChangeEmailInitialState extends AuthState {}

final class ChangeEmailLoadingState extends AuthState {}

final class ChangeEmailSuccessState extends AuthState {}

final class ChangeEmailErrorState extends AuthState {
  ChangeEmailErrorState({required this.message});
  final String message;
}
 


//

final class EmailVerifiedState extends AuthState {}

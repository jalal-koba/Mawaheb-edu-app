part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitialState extends NotificationsState {}

final class NotificationsLoadingState extends NotificationsState {}

final class NotificationsSuccessState extends NotificationsState {}

final class NotificationsErrorState extends NotificationsState {
  NotificationsErrorState({required this.message});
  final String message;
}

final class MakeUnreadZeroState extends NotificationsState {}
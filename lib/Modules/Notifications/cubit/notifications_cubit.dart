import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Notifications/Models/notification.dart';
import 'package:talents/Modules/Notifications/Models/notifications_response.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitialState());
  static NotificationsCubit get(context) => BlocProvider.of(context);

  int page = 1;
  int unreadNotifications = 0;
  final RefreshController refreshController = RefreshController();
  List<AppNotification> notifications = [];

  void makeUnreadZero() {
    unreadNotifications = 0;
    emit(MakeUnreadZeroState());
  }

  Future<void> getNotifications({int markRead = 0}) async {
    if (page == 1) {
      emit(NotificationsLoadingState());
    }

    try {
      final Response response = await Network.getData(
          url: Urls.notifications(read: markRead, page: page));
      final NotificationsResponse notificationsResponse =
          NotificationsResponse.fromJson(response.data);

      if (page > 1) {
        notifications.addAll(notificationsResponse.data.data);
        if (notificationsResponse.data.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        notifications = notificationsResponse.data.data;
      unreadNotifications = notificationsResponse.notificationsCount;
      }
      page = notificationsResponse.data.currentPage + 1;


      emit(NotificationsSuccessState());
    } on DioException catch (error) {
      emit(NotificationsErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(NotificationsErrorState(message: "حدث خطأ ما"));
    }
  }
}

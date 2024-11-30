import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Helper/app_sharedPreferance.dart';
import 'package:talents/main.dart';

class NotificationsFunctions {
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: "important notification",
      importance: Importance.high,
      playSound: true);

  static FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static init() async {
    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await getNotificationPermission();

    receiveMessageOnfourground();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        _handleNotificationClick(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(message);
    });
  }

  static void _handleNotificationClick(RemoteMessage? message) {
    notificationDialog(message!);

    String? token = AppSharedPreferences.getToken;

    print("isGuest : $token");
    if (token != null) {
      navigatorKey.currentState?.pushNamed("/notification-screen");
    }
  }

  static Future<void> getNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission==========================');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission]=====================');
    } else {
      print(
          'User declined or has not accepted permission=====================');
    }
  }

  static void receiveMessageOnfourground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "===========get notification in fourground =on message ===========");

      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print("${message.data}++++++++++++++++++++");

        print("ending");

        notificationDialog(message);

        print(message.data);

        if (message.data['state'] == "5") { 
  
          }
      }
    });
  }

  static void notificationDialog(RemoteMessage message) {
    plugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentBanner: true,
              presentSound: true,
              interruptionLevel: InterruptionLevel.active),
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              color: AppColors.primary,
              playSound: true, 
              icon: "@mipmap/ic_launcher_foreground"),
        ));
  }
}

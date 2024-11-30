import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Helper/app_sharedPreferance.dart';
import 'package:talents/Helper/cach_helper.dart';
import 'package:talents/Modules/Home/Cubit/cubit/main_page_cubit.dart';
import 'package:talents/Modules/Notifications/Tools/notifications_functions.dart';
import 'package:talents/Modules/Notifications/View/notification_screen.dart';
import 'package:talents/Modules/Notifications/cubit/notifications_cubit.dart';
import 'package:talents/Modules/Auth/Cubit/profile_cubit.dart';
import 'package:talents/Modules/Startup/View/Screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:talents/Theme/app_theme.dart';
import 'package:talents/firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.secondary,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: AppColors.secondary,
    systemNavigationBarColor: AppColors.secondary,
    systemNavigationBarContrastEnforced: true,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();

  await Network.init();

  NotificationsFunctions.init();
  // print("token ${AppSharedPreferences.getToken}");
  print("fcmtoken ${await FirebaseMessaging.instance.getToken()}");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light));
    return Sizer(
        builder: (context, orientation, deviceType) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => ProfileCubit(),
                  ),
                  BlocProvider(
                    create: (context) => MainPageCubit(),
                  ),
                  BlocProvider(
                      lazy: false,
                      create: (context) {
                        if (AppSharedPreferences.hasToken) {
                          return NotificationsCubit()..getNotifications();
                        }

                        return NotificationsCubit();
                      }),
                ],
                child: MaterialApp(
                  navigatorKey: navigatorKey,
                  routes: {
                    "/": (context) => const SplashScreen(),
                    "/notification-screen": (context) => const NotificationScreen()
                  },
                  theme: AppTheme.theme,
                  locale: const Locale('ar'),
                  supportedLocales: const [
                    Locale('en', ''),
                    Locale('ar', ''),
                  ],
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  debugShowCheckedModeBanner: false,
                  // home: SplashScreen(),
                )));
  }
}

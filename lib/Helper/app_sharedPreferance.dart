import 'package:talents/Helper/cach_helper.dart';

class AppSharedPreferences {
  //token
  static String token = 'token';
  static String? get getToken => CacheHelper.getData(key: token);
  static saveToken(String value) =>
      CacheHelper.saveData(key: token, value: value);
  static bool get hasToken => CacheHelper.contains(token);
  static void get removeToken => CacheHelper.removeData(key: token);

  static void saveQuality(int value) =>
      CacheHelper.saveData(key: "quality", value: value);
      
  static int get getQuality =>
      CacheHelper.getData(
        key: "quality",
      ) ??
      -1;
}

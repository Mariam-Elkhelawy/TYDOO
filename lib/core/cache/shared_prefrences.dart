import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences preferences;
  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static String? getData(String key) {
    return preferences.getString(key);
  }

  static Future<bool> deleteData(String key) async {
    return await preferences.remove(key);
  }

  static Future<bool> saveData(String key, dynamic value) async {
    if (value is String) {
      return await preferences.setString(key, value);
    }
    if (value is double) {
      return await preferences.setDouble(key, value);
    }
    if (value is int) {
      return await preferences.setInt(key, value);
    }
    if (value is bool) {
      return await preferences.setBool(key, value);
    } else {
      return false;
    }
  }

  static bool isLoginToken() {
    if (CacheHelper.getData("token") == null ||
        CacheHelper.getData("token")!.isEmpty ||
        CacheHelper.getData("token") == "") {
      return false;
    }
    return true;
  }
}

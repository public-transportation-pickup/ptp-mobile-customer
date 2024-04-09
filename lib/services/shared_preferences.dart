import 'package:shared_preferences/shared_preferences.dart';

class SharedRef {
  static const String _key = 'jwtToken';
  static const _notificationCountKey = 'notificationCount';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static Future<int> getNotificationCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_notificationCountKey) ?? 0;
  }

  static Future<void> setNotificationCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_notificationCountKey, count);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  // ✅ Initialize (بيتنادى في main)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ✅ Save
  static Future<void> saveValue({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    }
  }

  // ✅ Get
  static dynamic getValue({required String key}) {
    return _prefs.get(key);
  }

  // ✅ Remove
  static Future<void> removeValue({required String key}) async {
    await _prefs.remove(key);
  }

  // ✅ Clear All
  static Future<void> clearAll() async {
    await _prefs.clear();
  }
}
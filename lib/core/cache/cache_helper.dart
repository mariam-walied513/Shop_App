import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheHelper {
  static late SharedPreferences _prefs;
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setValue({
    required String key,
    required dynamic value,
  }) async {
    _prefs = await SharedPreferences.getInstance();
    if (value is int) {
      return await _prefs.setInt(key, value);
    } else if (value is double) {
      return await _prefs.setDouble(key, value);
    } else if (value is bool) {
      return await _prefs.setBool(key, value);
    } else if (value is List<String>) {
      return await _prefs.setStringList(key, value);
    } else {
      return await _prefs.setString(key, value.toString());
    }
  }

  static Object? getValue({required String key}) {
    return _prefs.get(key);
  }

  static Future<bool> removeValue({required String key}) {
    return _prefs.remove(key);
  }
}



// class CacheHelper {
//   static SharedPreferences? _prefs;

//   // دالة التهيئة
//   static Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   // دالة جلب الـ Instance بضمان عدم الـ Null
//   static Future<SharedPreferences> _getPrefs() async {
//     _prefs ??= await SharedPreferences.getInstance();
//     return _prefs!;
//   }

//   // دالة الحفظ الآمنة تماماً
//   static Future<bool> saveData({
//     required String key,
//     required dynamic value,
//   }) async {
//     final prefs = await _getPrefs(); // 👈 بتضمن إن SharedPreferences جاهز 100%

//     if (value is String) return await prefs.setString(key, value);
//     if (value is int) return await prefs.setInt(key, value);
//     if (value is bool) return await prefs.setBool(key, value);
//     if (value is double) return await prefs.setDouble(key, value);
//     return false;
//   }

//   // دالة القراءة الآمنة
//   static dynamic getData({required String key}) {
//     return _prefs?.get(key);
//   }
// }
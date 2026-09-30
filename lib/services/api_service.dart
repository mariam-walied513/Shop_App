import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ✅ Singleton
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  static const String baseUrl =
      'https://nti-ecommerce-api-production-8a47.up.railway.app/api';

  static const String _email = 'ahmed@gmail.com';
  static const String _password = '123456';

  String? _accessToken;
  Map<String, dynamic>? _userData;

  String? get token => _accessToken;
  Map<String, dynamic>? get userData => _userData;

  // ✅ Login + يرجع بيانات المستخدم
  Future<Map<String, dynamic>?> loginAndGetUser() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'email': _email, 'password': _password},
      );

      print('✅ Login Status: ${response.statusCode}');
      print('✅ Login Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _accessToken = data['access_token'];
        _userData = data['user'];
        print('👤 User: $_userData');
        return _userData;
      }
      return null;
    } catch (e) {
      print('❌ Login error: $e');
      return null;
    }
  }

  // ✅ Login (بس للـ Token)
  Future<String?> login() async {
    final data = await loginAndGetUser();
    return data != null ? _accessToken : null;
  }

  // ✅ Place Order
  Future<Map<String, dynamic>?> placeOrder(
    List<Map<String, int>> items,
  ) async {
    try {
      if (_accessToken == null) await login();

      if (_accessToken == null) return null;

      final response = await http.post(
        Uri.parse('$baseUrl/place_order'),
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'items': items}),
      );

      print('✅ Order Status: ${response.statusCode}');
      print('✅ Order Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print('❌ Place order error: $e');
      return null;
    }
  }

  // ✅ Logout
  void logout() {
    _accessToken = null;
    _userData = null;
  }
}
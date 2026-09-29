import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ✅ Singleton — instance واحدة لكل التطبيق
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  static const String baseUrl =
      'https://nti-ecommerce-api-production-8a47.up.railway.app/api';

  static const String _email = 'ahmed@gmail.com';
  static const String _password = '123456';

  String? _accessToken;

  // ✅ Login
  Future<String?> login() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'email': _email, 'password': _password},
      );

      print('✅ Login Status: ${response.statusCode}');
      print('✅ Login Body: ${response.body}');

      if (response.statusCode == 200) {
        _accessToken = jsonDecode(response.body)['access_token'];
        print('🔑 Token saved: $_accessToken');
        return _accessToken;
      }
      return null;
    } catch (e) {
      print('❌ Login error: $e');
      return null;
    }
  }

  // ✅ Place Order
  Future<Map<String, dynamic>?> placeOrder(
    List<Map<String, int>> items,
  ) async {
    try {
      // ✅ لو مفيش Token → Login
      if (_accessToken == null) {
        print('⚠️ No token, logging in...');
        await login();
      }

      print('🔑 Using Token: $_accessToken');
      print('📦 Items: $items');

      if (_accessToken == null) {
        print('❌ Token is null after login');
        return null;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/place_order'),
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'items': items}),
      );

      print('✅ Response Status: ${response.statusCode}');
      print('✅ Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print('❌ Place order error: $e');
      return null;
    }
  }

  String? get token => _accessToken;
}
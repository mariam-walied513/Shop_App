import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/api_service.dart';
import '../core/cache/cache_helper.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final ApiService _api = ApiService();

  Future<void> login() async {
    emit(AuthLoading());

    try {
      final data = await _api.loginAndGetUser();

      if (data != null) {
        final name = data['name'] ?? 'Guest';
        final email = data['email'] ?? '';
        final phone = data['phone'] ?? '';

        // ✅ حفظ بيانات المستخدم
        await CacheHelper.saveValue(key: 'userName', value: name);
        await CacheHelper.saveValue(key: 'userEmail', value: email);
        await CacheHelper.saveValue(key: 'userPhone', value: phone);

        emit(AuthLoaded(
          name: name,
          email: email,
          phone: phone,
        ));
      } else {
        // ✅ جرب اقرأ من الـ Cache لو الـ API فشل
        final cachedName = CacheHelper.getValue(key: 'userName');
        if (cachedName != null) {
          emit(AuthLoaded(
            name: cachedName.toString(),
            email: CacheHelper.getValue(key: 'userEmail')?.toString() ?? '',
            phone: CacheHelper.getValue(key: 'userPhone')?.toString() ?? '',
          ));
        } else {
          emit(AuthError('Login failed'));
        }
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void logout() {
    CacheHelper.removeValue(key: 'userName');
    CacheHelper.removeValue(key: 'userEmail');
    CacheHelper.removeValue(key: 'userPhone');
    _api.logout();
    emit(AuthInitial());
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:my_new_app/features/auth/data/models/login_response_model.dart';
import 'package:my_new_app/features/auth/data/repo/auth_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo repo; // تجنب إنشاء أوبجكت جديد داخل الدالة

  RegisterCubit(this.repo) : super(RegisterInitState());

  bool isPasswordSecure = true;
  bool isConfirmPasswordSecure = true;

  void changePassSecure() {
    isPasswordSecure = !isPasswordSecure;
    emit(RegisterPassVisibilityChanged());
  }

  void changeConfirmPassSecure() {
    isConfirmPasswordSecure = !isConfirmPasswordSecure;
    emit(RegisterConfirmPassVisibilityChanged());
  }

  void register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // 1. التحقق من تطابق الباسورد
    if (password != confirmPassword) {
      emit(RegisterErrorState('Passwords do not match'));
      return;
    }

    emit(RegisterLoadingState());

    // 2. إرسال البيانات المباشرة للـ Repo
var result = await repo.register(
  name: name,
  phone: phone,
  email: email,
  password: password,
  confirmPassword: confirmPassword,
);

    result.fold(
      (errorMsg) => emit(RegisterErrorState(errorMsg)),
      (userModel) => emit(RegisterSuccessState(userModel)),
    );
  }
}
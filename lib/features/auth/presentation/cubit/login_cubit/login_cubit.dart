import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_new_app/features/auth/data/repo/auth_repo.dart';
import 'package:my_new_app/features/auth/presentation/cubit/login_cubit/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
 final AuthRepo repo;

LoginCubit(this.repo) : super(LoginInitState());

 final email = TextEditingController();
 final password = TextEditingController();
 
 bool isPasswordSecure = true;

 void changePassSecure() {
  isPasswordSecure = !isPasswordSecure;
 emit(LoginPassVisibilityChanged(isPasswordSecure));
 }

 Future<void> login({
 required String email,
 required String password,
}) async {
 emit(LoginLoadingState());

 final result = await repo.login(
 email: email,
 password: password,
 );

result.fold(
 (errorMsg) => emit(LoginErrorState(errorMsg)),
 (userModel) => emit(LoginSuccessState(userModel)),
 );
}

 @override
Future<void> close() {
 email.dispose();
 password.dispose();
 return super.close();
 }
}
import 'package:my_new_app/features/auth/data/models/login_response_model.dart';


abstract class RegisterState {}

class RegisterInitState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final UserModel userModel;
  RegisterSuccessState(this.userModel);
}

class RegisterErrorState extends RegisterState {
  final String errorMsg;
  RegisterErrorState(this.errorMsg);
}

class RegisterPassVisibilityChanged extends RegisterState {}

class RegisterConfirmPassVisibilityChanged extends RegisterState {}
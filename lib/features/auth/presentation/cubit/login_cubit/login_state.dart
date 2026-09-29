import 'package:my_new_app/features/auth/data/models/login_response_model.dart';

abstract class LoginState {}

class LoginInitState extends LoginState{}
class LoginPassVisibilityChanged extends LoginState{
  LoginPassVisibilityChanged(bool isPasswordSecure);
}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{
  final UserModel userModel;
  LoginSuccessState(this.userModel);
}
class LoginErrorState extends LoginState{
  final String errorMsg;
  LoginErrorState(this.errorMsg);
}
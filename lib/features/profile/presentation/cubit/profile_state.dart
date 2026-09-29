import 'package:my_new_app/features/profile/data/models/user_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final UserModel user;
  ProfileSuccessState(this.user);
}

class ProfileErrorState extends ProfileState {
  final String errorMsg;
  ProfileErrorState(this.errorMsg);
}
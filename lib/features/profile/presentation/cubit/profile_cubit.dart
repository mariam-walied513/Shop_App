import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_new_app/core/cache/cache_helper.dart';
import 'package:my_new_app/core/cache/cache_keys.dart';
import 'package:my_new_app/features/profile/data/models/user_model.dart';
import 'package:my_new_app/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  final Dio _dio = Dio();

  void fetchProfile() async {
    emit(ProfileLoadingState());
    try {
      final token = CacheHelper.getValue(key: CacheKeys.accessToken);

      final response = await _dio.get(
        'https://nti-ecommerce-api-production-8a47.up.railway.app/api/get_user_data',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final userData = UserModel.fromJson(response.data['data'] ?? response.data);
        emit(ProfileSuccessState(userData));
      } else {
        emit(ProfileErrorState('Failed to fetch data'));
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
}
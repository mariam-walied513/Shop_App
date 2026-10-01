import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_new_app/core/cache/cache_helper.dart';
import 'package:my_new_app/core/cache/cache_keys.dart';
import 'package:my_new_app/core/network/api_helper.dart';
import 'package:my_new_app/core/network/end_points.dart';
import 'package:my_new_app/features/auth/data/models/login_response_model.dart';

class AuthRepo {
  final ApiHelper apiHelper = ApiHelper();

 
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {
          'email': email,
          'password': password,
        },
        isFormData: true,
      );

      final Map<String, dynamic> jsonResponse = 
          response.data is Map<String, dynamic> 
              ? response.data 
              : Map<String, dynamic>.from(response.data);

      LoginResponseModel model = LoginResponseModel.fromJson(jsonResponse);

      if (model.accessToken != null) {
        await CacheHelper.setValue(
          key: CacheKeys.accessToken,
          value: model.accessToken,
        );
      }

      if (model.refreshToken != null) {
        await CacheHelper.setValue(
          key: CacheKeys.refreshToken,
          value: model.refreshToken,
        );
      }

    
      if (model.userModel != null) {
        return right(model.userModel!);
      } else {
        return left(model.message ?? 'فشل تسجيل الدخول');
      }
    } catch (e) {
      return left(apiHelper.handleException(e));
    }
  }

 
  Future<Either<String, UserModel>> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
        isFormData: true,
      );

      final Map<String, dynamic> jsonResponse = 
          response.data is Map<String, dynamic> 
              ? response.data 
              : Map<String, dynamic>.from(response.data);

      LoginResponseModel model = LoginResponseModel.fromJson(jsonResponse);

     
      if (model.accessToken != null) {
        await CacheHelper.setValue(
          key: CacheKeys.accessToken,
          value: model.accessToken,
        );
      }

      if (model.refreshToken != null) {
        await CacheHelper.setValue(
          key: CacheKeys.refreshToken,
          value: model.refreshToken,
        );
      }

      
      if ((model.status == true || jsonResponse['status'] == 'true') &&
          model.userModel != null) {
        return right(model.userModel!);
      } else {
        return left(model.message ?? 'فشل إنشاء الحساب');
      }
    } catch (e) {
      return left(apiHelper.handleException(e));
    }
  }
}
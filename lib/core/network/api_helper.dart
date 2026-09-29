import 'package:dio/dio.dart';
import 'package:my_new_app/core/cache/cache_helper.dart';
import 'package:my_new_app/core/cache/cache_keys.dart';
import 'end_points.dart';

class ApiHelper {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('------------------------------------------');
          print("Request: ${options.method} ${options.path}");
          print("Headers: ${options.headers}");
          if (options.data is FormData) {
            print("FormData Fields: ${(options.data as FormData).fields}");
          } else {
            print("Data: ${options.data}");
          }
          print("queryParameters: ${options.queryParameters}");
          print('------------------------------------------');
          return handler.next(options);
        },
        onError: (error, handler) {
          print('------------------------------------------');
          print("Error Path: ${error.requestOptions.path} [${error.response?.statusCode}]");
          print("Error Response: ${error.response?.data}");
          print('------------------------------------------');
          return handler.next(error);
        },
        onResponse: (response, handler) {
          print('------------------------------------------');
          print("Response Path: ${response.requestOptions.path} [${response.statusCode}]");
          print("Response Data: ${response.data}");
          print('------------------------------------------');
          return handler.next(response);
        },
      ),
    );

  Future<Response> postRequest({
    required String endPoint,
    dynamic data,
    bool isFormData = true,
    bool isPrivate = false,
  }) async {
    dynamic finalData = data;

    if (data != null) {
      if (data is FormData) {
        finalData = data;
      } else if (isFormData && data is Map<String, dynamic>) {
        finalData = FormData.fromMap(data);
      }
    }

    return _dio.post(
      endPoint,
      data: finalData,
      options: Options(
        headers: {
          if (isPrivate)
            'Authorization':
                'Bearer ${CacheHelper.getValue(key: CacheKeys.accessToken)}',
        },
      ),
    );
  }

  Future<Response> getRequest({
    required String endPoint,
    dynamic queryParams,
    bool isPrivate = false,
  }) async {
    return _dio.get(
      endPoint,
      queryParameters: queryParams,
      options: Options(
        headers: {
          if (isPrivate)
            'Authorization':
                'Bearer ${CacheHelper.getValue(key: CacheKeys.accessToken)}',
        },
      ),
    );
  }

  String handleException(Object e) {
    if (e is DioException) {
      if (e.response?.data != null) {
        var errorResponse = e.response!.data;

        // استخراج رسالة الخطأ سواء كانت Map أو String
        if (errorResponse is Map) {
          // التعامل مع أخطاء الـ Validation (إذا كانت الأخطاء قائمة داخل errors)
          if (errorResponse.containsKey('errors') && errorResponse['errors'] is Map) {
            Map errors = errorResponse['errors'];
            return errors.values.first.first.toString();
          }
          
          return errorResponse['message']?.toString() ?? 
                 errorResponse['error']?.toString() ?? 
                 'بيانات المدخلات غير صحيحة';
        } else if (errorResponse is String) {
          return errorResponse;
        }
      }
      
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'انتهت مهلة الاتصال بالخادم، حاول مجدداً';
        case DioExceptionType.connectionError:
          return 'تعذر الاتصال بالخادم، تأكدي من الاتصال بالإنترنت';
        default:
          return 'حدث خطأ في الاتصال، حاول لاحقاً';
      }
    }

    print('Original Error: $e');
    return e.toString();
  }
}
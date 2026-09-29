class LoginResponseModel {
  String? accessToken;
  String? refreshToken;
  bool? status;
  String? message;
  UserModel? userModel;

  LoginResponseModel({
    this.accessToken,
    this.refreshToken,
    this.status,
    this.message,
    this.userModel,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      status: json['status'] is bool 
          ? json['status'] 
          : (json['status']?.toString() == 'true'),
      message: json['message'] as String?,
      // ✅ فحص وجود مفتاح user وتأكيد أنه Map قبل التحويل لمنع أخطاء الـ Null
      userModel: (json['user'] != null && json['user'] is Map<String, dynamic>)
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UserModel {
  String? email;
  List<dynamic>? favouriteProducts;
  int? id;
  String? imagePath;
  String? name;
  String? phone;

  UserModel({
    this.email,
    this.favouriteProducts,
    this.id,
    this.imagePath,
    this.name,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String?,
      favouriteProducts: json['favorite_products'] as List<dynamic>?,
      id: json['id'] as int?,
      imagePath: json['image_path'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );
  }
}
class UserModel {
  final String? name;
  final String? phone;
  final String? image;

  UserModel({
    this.name,
    this.phone,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? json['full_name'] ?? json['userName'],
      phone: json['phone'] ?? json['phoneNumber'],
      image: json['image'] ?? json['avatar'],
    );
  }
}
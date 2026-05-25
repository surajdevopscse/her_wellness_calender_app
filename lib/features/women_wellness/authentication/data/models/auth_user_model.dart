import 'package:her_wellness_calender/features/women_wellness/authentication/domain/entities/auth_user.dart';

class AuthUserModel {
  const AuthUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.mobile,
    this.password,
  });

  final String id;
  final String fullName;
  final String email;
  final String? mobile;
  final String? password;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        if (mobile != null) 'mobile': mobile,
      };

  AuthUser toEntity() => AuthUser(
        id: id,
        fullName: fullName,
        email: email,
        mobile: mobile,
      );
}

import 'package:to_do_application/data/models/user_model.dart';

class AuthModel {
  final String status;
  final String accessToken;
  final UserModel userModel;

  AuthModel({
    required this.status,
    required this.accessToken,
    required this.userModel,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      status: json['status'] ?? '',
      accessToken: json['accessToken'] ?? '',
      userModel: UserModel.fromJson(json['userModel'] ?? {}),
    );
  }
}
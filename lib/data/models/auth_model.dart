import 'package:to_do_application/data/models/user_model.dart';

class AuthModel {
  late final String status;
  late final String token;
  late final UserModel userModel;

  AuthModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'] ?? '';
    userModel = UserModel.fromJson(jsonData['data'] ?? {});
    token = jsonData['token'] ?? '';
  }
}
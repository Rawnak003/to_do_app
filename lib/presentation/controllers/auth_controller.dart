import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_application/data/models/user_model.dart';

class AuthController {

  static String? token;
  static UserModel? usersModel;

  static final String _tokenKey = 'token';
  static final String _userDataKey = 'user-data';

  static Future<void> saveUserInfo(String accessToken, UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, accessToken);
    await sharedPreferences.setString(_userDataKey, jsonEncode(userModel.toJson()));

    token = accessToken;
    usersModel = userModel;
  }

  static Future<void> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(_tokenKey);
    String? userData = sharedPreferences.getString(_userDataKey);
    usersModel = userData != null ? UserModel.fromJson(jsonDecode(userData)) : null;
  }
}
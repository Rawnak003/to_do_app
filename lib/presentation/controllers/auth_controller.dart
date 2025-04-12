import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_application/data/models/user_model.dart';

class AuthController {
  static String? token;
  static UserModel? userModel;
  static String? profilePhoto;

  static const String _tokenKey = 'token';
  static const String _userDataKey = 'user-data';

  static Future<void> saveUserInformation(String accessToken, UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, accessToken);
    sharedPreferences.setString(_userDataKey, jsonEncode(user.toJson()));
    profilePhoto = user.photo;
    token = accessToken;
    userModel = user;
  }

  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    String? savedUserModelString = sharedPreferences.getString(_userDataKey);
    if (savedUserModelString != null) {
      UserModel savedUserModel = UserModel.fromJson(jsonDecode(savedUserModelString));
      userModel = savedUserModel;
      profilePhoto = savedUserModel.photo;
      print("Profile Photo: $profilePhoto");
    }
    token = accessToken;
  }

  static Future<bool> checkIfUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userAccessToken = sharedPreferences.getString(_tokenKey);
    if (userAccessToken != null) {
      await getUserInformation();
      return true;
    }
    return false;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
    userModel = null;
  }

  static Future<void> saveUserPass(String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('pass', pass);
  }

  static Future<String?> getUserPass() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userAccess = sharedPreferences.getString('pass');
    if (userAccess != null) {
      return userAccess;
    }
    return null;
  }

  static Future<void> saveUpdatedUserDetailsToPrefsWithoutPassword(Map<String, dynamic> userDetails) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Update the in-memory userModel
    if (userModel != null) {
      userModel = userModel!.copyWith(
        email: userDetails["email"],
        firstName: userDetails["firstName"],
        lastName: userDetails["lastName"],
        mobile: userDetails["mobile"],
        photo: userDetails["photo"] ?? userModel!.photo,
      );

      // Save updated model to shared preferences
      await prefs.setString(_userDataKey, jsonEncode(userModel!.toJson()));
      profilePhoto = userModel!.photo;
    }
  }

  static Future<void> saveUpdatedUserDetailsToPrefsWithPassword(Map<String, dynamic> userDetails) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (userModel != null) {
      userModel = userModel!.copyWith(
        email: userDetails["email"],
        firstName: userDetails["firstName"],
        lastName: userDetails["lastName"],
        mobile: userDetails["mobile"],
        photo: userDetails["photo"] ?? userModel!.photo,
      );

      await prefs.setString(_userDataKey, jsonEncode(userModel!.toJson()));
      profilePhoto = userModel!.photo;
    }

    if (userDetails.containsKey("password")) {
      await prefs.setString("password", userDetails["password"]);
    }
  }

}
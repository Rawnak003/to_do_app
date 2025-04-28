import 'package:get/get.dart';
import 'package:to_do_application/data/models/auth_model.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';
import 'package:to_do_application/presentation/controllers/auth_controller.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  String? _message;

  bool get loginInProgress => _loginInProgress;
  String? get message => _message;

  Future<bool> loginUser(String email, String password) async {
    bool isLoginSuccess = false;
    _loginInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: AppURLs.loginURL,
      body: requestBody,
    );

    if (response.isSuccess) {
      AuthModel loginModel = AuthModel.fromJson(response.data!);
      await AuthController.saveUserInformation(loginModel.token, loginModel.userModel);
      await AuthController.saveUserPass(password);
      isLoginSuccess = true;
      _message = "Login Successfully!";
    } else {
      _message = "Login Failed!";
    }

    _loginInProgress = false;
    update();
    return isLoginSuccess;
  }

}
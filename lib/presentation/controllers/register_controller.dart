
import 'package:get/get.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';

class RegisterController extends GetxController {
  bool _registerInProgress = false;
  String? _message;

  bool get registerInProgress => _registerInProgress;
  String? get message => _message;

  Future<bool> registerUser(String email, String firstName, String lastName, String phone, String password) async {
    bool isRegisterSuccess = false;
    _registerInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": phone,
      "password": password,
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: AppURLs.registerURL,
      body: requestBody,
    );

    if (response.isSuccess) {
      isRegisterSuccess = true;
      _message = "Register Successfully!";
    } else {
      _message = "Register Failed!";
    }

    _registerInProgress = false;
    update();
    return isRegisterSuccess;
  }
}
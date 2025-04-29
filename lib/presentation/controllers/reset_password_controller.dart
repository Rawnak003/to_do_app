import 'package:get/get.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';

class ResetPasswordController extends GetxController {
  bool _reSetInProgress = false;
  String? _message;

  bool get reSetInProgress => _reSetInProgress;
  String? get message => _message;

  Future<bool> resetPassword(String email, String userOTP, String newPassword, String confirmPassword) async {
    bool isResetSuccess = false;
    _reSetInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": userOTP,
    };

    if (newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (newPassword !=
          confirmPassword) {
        Get.snackbar("Error", "The Passwords do not match");
        _reSetInProgress = false;
        update();
        return isResetSuccess;
      }
      requestBody["password"] = newPassword;
    }

    NetworkResponse response = await NetworkClient.postRequest(
      url: AppURLs.resetPasswordURL,
      body: requestBody,
    );

    if (response.isSuccess) {
      isResetSuccess = true;
      _message = "Reset Password Successfully!";
    } else {
      _message = "Reset Password Failed!";
    }

    _reSetInProgress = false;
    update();
    return isResetSuccess;
  }
}

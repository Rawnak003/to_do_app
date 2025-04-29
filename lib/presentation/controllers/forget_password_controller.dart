import 'package:get/get.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';

class ForgetPasswordController extends GetxController {
  bool _getTheEmailVerifiedInProcess = false;
  String? _message;

  bool get getTheEmailVerifiedInProcess => _getTheEmailVerifiedInProcess;
  String? get message => _message;

  Future<bool> verifyTheEmail(String email) async {
    bool isEmailVerified = false;
    _getTheEmailVerifiedInProcess = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.verifyEmailURL(email),
    );

    if (response.isSuccess) {
      isEmailVerified = true;
      _message = "A 6 digit OTP code sent to your email";
    } else {
      _message = response.message;
    }
    _getTheEmailVerifiedInProcess = true;
    update();
    return isEmailVerified;
  }
}
import 'package:get/get.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';

class ForgetPasswordPinVerifyController extends GetxController {
  bool _getThePinVerifiedInProcess = false;
  String? _message;

  bool get getThePinVerifiedInProcess => _getThePinVerifiedInProcess;
  String? get message => _message;

  Future<bool> verifyThePin(String email, String pin) async {
    bool isPinVerified = false;
    _getThePinVerifiedInProcess = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.verifyPinURL(email, pin),
    );

    if (response.isSuccess) {
      isPinVerified = true;
      _message = "Pin verified Successfully";
    } else {
      _message = response.message;
    }
    _getThePinVerifiedInProcess = true;
    update();
    return isPinVerified;
  }
}
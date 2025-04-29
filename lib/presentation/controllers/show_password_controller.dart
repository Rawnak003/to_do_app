import 'package:get/get.dart';

class ShowPasswordController extends GetxController {
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  bool get showNewPassword => _showNewPassword;
  bool get showConfirmPassword => _showConfirmPassword;

  void toggleNewPassword() {
    _showNewPassword = !_showNewPassword;
    update();
  }

  void toggleConfirmPassword() {
    _showConfirmPassword = !_showConfirmPassword;
    update();
  }
}

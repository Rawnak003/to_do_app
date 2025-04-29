import 'package:get/get.dart';

class ShowPasswordController extends GetxController {
  bool obscurePassword = true;

  void toggleObscure() {
    obscurePassword = !obscurePassword;
    update();
  }
}

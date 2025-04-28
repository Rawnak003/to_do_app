import 'package:get/get.dart';
import 'package:to_do_application/presentation/controllers/login_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
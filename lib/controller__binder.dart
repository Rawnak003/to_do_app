import 'package:get/get.dart';
import 'package:to_do_application/presentation/controllers/login_controller.dart';
import 'package:to_do_application/presentation/controllers/main_bottom_nav_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(MainBottomNavController());
  }
}
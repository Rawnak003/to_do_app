import 'package:get/get.dart';
import 'package:to_do_application/presentation/controllers/add_task_controller.dart';
import 'package:to_do_application/presentation/controllers/forget_password_controller.dart';
import 'package:to_do_application/presentation/controllers/forget_password_pin_verify_controller.dart';
import 'package:to_do_application/presentation/controllers/login_controller.dart';
import 'package:to_do_application/presentation/controllers/main_bottom_nav_controller.dart';
import 'package:to_do_application/presentation/controllers/new_task_list_controller.dart';
import 'package:to_do_application/presentation/controllers/register_controller.dart';
import 'package:to_do_application/presentation/controllers/reset_password_controller.dart';
import 'package:to_do_application/presentation/controllers/show_password_controller.dart';
import 'package:to_do_application/presentation/controllers/task_status_count_list_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(MainBottomNavController());
    Get.put(NewTaskListController());
    Get.put(TaskStatusCountListController());
    Get.put(RegisterController());
    Get.put(ForgetPasswordController());
    Get.put(ForgetPasswordPinVerifyController());
    Get.put(ResetPasswordController());
    Get.put(ShowPasswordController());
    Get.put(AddTaskController());
  }
}
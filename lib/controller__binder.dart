import 'package:get/get.dart';
import 'package:to_do_application/presentation/controllers/add_task_controller.dart';
import 'package:to_do_application/presentation/controllers/cancelled__task_list_controller.dart';
import 'package:to_do_application/presentation/controllers/completed_task_list_controller.dart';
import 'package:to_do_application/presentation/controllers/fab_visibility_controller.dart';
import 'package:to_do_application/presentation/controllers/forget_password_controller.dart';
import 'package:to_do_application/presentation/controllers/forget_password_pin_verify_controller.dart';
import 'package:to_do_application/presentation/controllers/image_picker_controller.dart';
import 'package:to_do_application/presentation/controllers/login_controller.dart';
import 'package:to_do_application/presentation/controllers/main_bottom_nav_controller.dart';
import 'package:to_do_application/presentation/controllers/new_task_list_controller.dart';
import 'package:to_do_application/presentation/controllers/progress_task_list_controller.dart';
import 'package:to_do_application/presentation/controllers/register_controller.dart';
import 'package:to_do_application/presentation/controllers/reset_password_controller.dart';
import 'package:to_do_application/presentation/controllers/show_password_controller.dart';
import 'package:to_do_application/presentation/controllers/task_status_count_list_controller.dart';
import 'package:to_do_application/presentation/controllers/user_password_update_controller.dart';
import 'package:to_do_application/presentation/controllers/user_profile_update_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(RegisterController());
    Get.put(ForgetPasswordController());
    Get.put(ForgetPasswordPinVerifyController());
    Get.put(ResetPasswordController());
    Get.put(ShowPasswordController());
    Get.put(MainBottomNavController());
    Get.put(FabVisibilityController());
    Get.put(NewTaskListController());
    Get.put(TaskStatusCountListController());
    Get.put(AddTaskController());
    Get.put(ProgressTaskListController());
    Get.put(CompletedTaskListController());
    Get.put(CancelledTaskListController());
    Get.put(ImagePickerController());
    Get.put(UserProfileUpdateController());
    Get.put(UserPasswordUpdateController());
  }
}
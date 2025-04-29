import 'package:get/get.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/presentation/screens/authentication/forget_pass_screen.dart';
import 'package:to_do_application/presentation/screens/authentication/login_screen.dart';
import 'package:to_do_application/presentation/screens/authentication/register_screen.dart';
import 'package:to_do_application/presentation/screens/features/add_task_screen.dart';
import 'package:to_do_application/presentation/screens/features/cancelled_task_screen.dart';
import 'package:to_do_application/presentation/screens/features/completed_task_screen.dart';
import 'package:to_do_application/presentation/screens/features/new_task_screen.dart';
import 'package:to_do_application/presentation/screens/features/progress_task_screen.dart';
import 'package:to_do_application/presentation/screens/features/update_profile_screen.dart';
import 'package:to_do_application/presentation/screens/parent_screen/main_bottom_nav_screen.dart';
import 'package:to_do_application/presentation/screens/splash_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: RoutesName.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RoutesName.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: RoutesName.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: RoutesName.forgetPassword,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: RoutesName.mainBottomNav,
      page: () => MainBottomNavScreen(),
    ),
    GetPage(
      name: RoutesName.newTask,
      page: () => const NewTaskScreen(),
    ),
    GetPage(
      name: RoutesName.progressTask,
      page: () => const ProgressTaskScreen(),
    ),
    GetPage(
      name: RoutesName.completedTask,
      page: () => const CompletedTaskScreen(),
    ),
    GetPage(
      name: RoutesName.cancelledTask,
      page: () => const CancelledTaskScreen(),
    ),
    GetPage(
      name: RoutesName.addTask,
      page: () => const AddTaskScreen(),
    ),
    GetPage(
      name: RoutesName.updateProfile,
      page: () => const UpdateProfileScreen(),
    ),
  ];
}

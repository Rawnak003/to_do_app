import 'package:flutter/material.dart';
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

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        );
      case RoutesName.register:
        return MaterialPageRoute(
          builder: (BuildContext context) => const RegisterScreen(),
        );
      case RoutesName.forgetPassword:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgetPasswordScreen(),
        );
      case RoutesName.mainBottomNav:
        return MaterialPageRoute(
          builder: (BuildContext context) => MainBottomNavScreen(),
        );
      case RoutesName.newTask:
        return MaterialPageRoute(
          builder: (BuildContext context) => const NewTaskScreen(),
        );
      case RoutesName.progressTask:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProgressTaskScreen(),
        );
      case RoutesName.completedTask:
        return MaterialPageRoute(
          builder: (BuildContext context) => const CompletedTaskScreen(),
        );
      case RoutesName.cancelledTask:
        return MaterialPageRoute(
          builder: (BuildContext context) => const CancelledTaskScreen(),
        );
      case RoutesName.addTask:
        return MaterialPageRoute(
          builder: (BuildContext context) => const AddTaskScreen(),
        );
      case RoutesName.updateProfile:
        return MaterialPageRoute(
          builder: (BuildContext context) => const UpdateProfileScreen(),
        );
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}

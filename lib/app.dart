import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/controller__binder.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/routes/app_routes.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/core/themes/button_theme.dart';
import 'package:to_do_application/core/themes/input_decoration.dart';
import 'package:to_do_application/core/themes/text_themes.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        colorSchemeSeed: AppColor.primaryColor,
        inputDecorationTheme: AppInputDecoration.inputDecoration(),
        elevatedButtonTheme: AppButtonTheme.buttonTheme(),
        textTheme: AppTextTheme.appTextTheme(),
      ),
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
      initialBinding: ControllerBinder(),
    );
  }
}

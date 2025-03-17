import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/themes/button_theme.dart';
import 'package:to_do_application/core/themes/input_decoration.dart';
import 'package:to_do_application/core/themes/text_themes.dart';
import 'package:to_do_application/presentation/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        colorSchemeSeed: AppColor.primaryColor,
        inputDecorationTheme: AppInputDecoration.inputDecoration(),
        elevatedButtonTheme: AppButtonTheme.buttonTheme(),
        textTheme: AppTextTheme.appTextTheme(),
      ),
      home: SplashScreen(),
    );
  }
}

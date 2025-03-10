import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';

class AppButtonTheme {
  static ElevatedButtonThemeData buttonTheme(){
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.whiteColor,
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )
      ),
    );
  }
}
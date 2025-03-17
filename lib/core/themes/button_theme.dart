import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';

class AppButtonTheme {
  static ElevatedButtonThemeData buttonTheme(){
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.maxFinite),
          backgroundColor: AppColor.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          )
      ),
    );
  }
}
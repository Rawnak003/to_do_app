import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';

class AppTextTheme {
  static TextTheme appTextTheme() {
    return const TextTheme(
      headlineSmall: TextStyle(color: Colors.grey, fontSize: 24),
      titleSmall: TextStyle(color: AppColor.primaryColor, fontSize: 14),
      headlineMedium: TextStyle(color: AppColor.blackColor, fontWeight: FontWeight.w600, fontSize: 32,),
      bodyLarge: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w400),
      titleMedium: TextStyle(color: AppColor.whiteColor, fontSize: 16),
      bodyMedium: TextStyle(color: AppColor.blackColor, fontSize: 14, fontWeight: FontWeight.w400),
    );
  }
}

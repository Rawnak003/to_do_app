import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';

class AppTextTheme {
  static TextTheme appTextTheme() {
    return const TextTheme(
      titleMedium: TextStyle(color: Colors.grey, fontSize: 24),
      titleSmall: TextStyle(color: AppColor.primaryColor, fontSize: 16),
      headlineMedium: TextStyle(
        color: AppColor.blackColor,
        fontWeight: FontWeight.w600,
        fontSize: 32,
      ),
    );
  }
}

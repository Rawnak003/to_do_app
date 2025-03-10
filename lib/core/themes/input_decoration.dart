import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';

class AppInputDecoration {
  static InputDecorationTheme inputDecoration(){
    return InputDecorationTheme(
      hintStyle: TextStyle(
        color: AppColor.greyColor,
        fontWeight: FontWeight.w400,
      ),
      fillColor: AppColor.whiteColor,
      filled: true,
      border: _getBorder(),
      enabledBorder: _getBorder(),
      focusedBorder: _getBorder(),
      errorBorder: _getBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  static OutlineInputBorder _getBorder(){
    return OutlineInputBorder(
      borderSide: BorderSide.none,
    );
  }
}

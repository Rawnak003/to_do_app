import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';

class CenterCircularIndicatorWidget extends StatelessWidget {
  const CenterCircularIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColor.primaryColor,
      ),
    );
  }
}
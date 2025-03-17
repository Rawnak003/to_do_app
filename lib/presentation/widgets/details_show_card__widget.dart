import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';

class DetailsShowCard extends StatelessWidget {
  const DetailsShowCard({
    super.key, required this.title, required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Card(
      elevation: 0,
      color: AppColor.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColor.whiteColor, width: 2),
      ),
      child: SizedBox(
        height: screenHeight * 0.08,
        width: screenWidth * 0.22,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$count", style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColor.whiteColor),),
            Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }
}
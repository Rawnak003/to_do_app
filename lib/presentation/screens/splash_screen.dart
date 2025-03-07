import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_application/core/constants/spacing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/splash_screen_images/background.svg',
            fit: BoxFit.fill,
          ),
          Center(
            child: Image.asset(
              'assets/images/splash_screen_images/logo.png',
              width: AppSpacing.screenWidth(context) * 0.5,
              height: AppSpacing.screenHeight(context) * 0.3,
              fit: BoxFit.cover,
            )
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/core/constants/spacing.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/core/utils/assets_path.dart';
import 'package:to_do_application/presentation/controllers/auth_controller.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    final bool isLoggedIn = await AuthController.checkIfUserLoggedIn();
    Get.offAllNamed(isLoggedIn ? RoutesName.mainBottomNav : RoutesName.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Image.asset(
            AssetsPath.splashLogoPng,
            width: AppSpacing.screenWidth(context) * 0.5,
            height: AppSpacing.screenHeight(context) * 0.3,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}


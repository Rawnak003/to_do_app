import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/presentation/screens/authentication/forget_password_pin_verify_screen.dart';
import 'package:to_do_application/presentation/screens/authentication/login_screen.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onTapLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (pre) => false,
    );
  }

  void _onTapNextButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgetPasswordPINVerifyScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.yourEmail,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppStrings.forgetPassInstructions,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: AppStrings.email),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () => _onTapNextButton(),
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 32,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    const SizedBox(height: 45),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppStrings.alreadyHaveAccount,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.blackColor,
                            ),
                          ),
                          TextSpan(
                            text: AppStrings.login,
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () => _onTapLogin(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';

import 'login_screen.dart';

class ForgetPasswordPINVerifyScreen extends StatefulWidget {
  const ForgetPasswordPINVerifyScreen({super.key});

  @override
  State<ForgetPasswordPINVerifyScreen> createState() => _ForgetPasswordPINVerifyScreenState();
}

class _ForgetPasswordPINVerifyScreenState extends State<ForgetPasswordPINVerifyScreen> {

  final TextEditingController _pinInputTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onTapLogin(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (pre) => false);
  }

  @override
  void dispose() {
    _pinInputTEController.dispose();
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
                      AppStrings.pinVerification,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppStrings.enterPinInstructions,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 28),
                    PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 45,
                        activeFillColor: AppColor.whiteColor,
                        inactiveFillColor: AppColor.whiteColor,
                        selectedFillColor: AppColor.whiteColor,
                        activeColor: AppColor.primaryColor,
                        inactiveColor: AppColor.whiteColor,
                        selectedColor: AppColor.secondaryColor,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: AppColor.backgroundColor,
                      enableActiveFill: true,
                      controller: _pinInputTEController,
                      appContext: context,
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.verify,
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ),
                    const SizedBox(height: 45),
                    RichText(text: TextSpan(children: [
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
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _onTapLogin(),
                      ),
                    ])),
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

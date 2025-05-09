import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/presentation/controllers/forget_password_pin_verify_controller.dart';
import 'package:to_do_application/presentation/screens/authentication/reset_password_screen.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';

class ForgetPasswordPINVerifyScreen extends StatefulWidget {
  const ForgetPasswordPINVerifyScreen({super.key, required this.userEmail});

  final String userEmail;

  @override
  State<ForgetPasswordPINVerifyScreen> createState() =>
      _ForgetPasswordPINVerifyScreenState();
}

class _ForgetPasswordPINVerifyScreenState extends State<ForgetPasswordPINVerifyScreen> {
  final TextEditingController _pinInputTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgetPasswordPinVerifyController _forgetPasswordPinVerifyController = Get.find<ForgetPasswordPinVerifyController>();

  void _onTapLogin() {
    Get.offAllNamed(RoutesName.login);
  }

  void _onTapVerifyButton() {
    if (_formKey.currentState!.validate()) {
      _verifyThePin();
    }
  }

  Future<void> _verifyThePin() async {
    final bool isPinVerified = await _forgetPasswordPinVerifyController.verifyThePin(widget.userEmail, _pinInputTEController.text.trim());
    if (isPinVerified) {
      Get.to(
            () => ResetPasswordScreen(
          userEmail: widget.userEmail,
          userOTP: _pinInputTEController.text.trim(),
        ),
      );
      Utils.toastMessage(_forgetPasswordPinVerifyController.message!);
    } else {
      Get.snackbar("Error", _forgetPasswordPinVerifyController.message!);
    }
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
                      style: Theme.of(context).textTheme.bodyMedium,
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
                      validator: (String? value) {
                        String pin = value?.trim() ?? '';
                        final RegExp pinRegex = RegExp(r'^\d{6}$');
                        if (pinRegex.hasMatch(pin) == false) {
                          return 'Please enter valid Pin';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 25),
                    GetBuilder<ForgetPasswordPinVerifyController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.getThePinVerifiedInProcess == false,
                          replacement: const CircularProgressIndicator(),
                          child: ElevatedButton(
                            onPressed: () => _onTapVerifyButton(),
                            child: Text(
                              AppStrings.verify,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        );
                      }
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

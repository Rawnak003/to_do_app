import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/presentation/controllers/forget_password_controller.dart';
import 'package:to_do_application/presentation/screens/authentication/forget_password_pin_verify_screen.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgetPasswordController _forgetPasswordController = Get.find<ForgetPasswordController>();

  void _onTapLogin() {
    Get.offAllNamed(RoutesName.login);
  }

  void _onTapNextButton() {
    if(_formKey.currentState!.validate()) {
      _verifyTheEmail();
    }
  }

  Future<void> _verifyTheEmail() async {
    final bool isEmailVerified = await _forgetPasswordController.verifyTheEmail(_emailTEController.text.trim());
    if (isEmailVerified) {
      Get.to(() => ForgetPasswordPINVerifyScreen(
          userEmail: _emailTEController.text.trim(),
        ),
      );
      Utils.toastMessage(_forgetPasswordController.message!);
    } else {
      Get.snackbar("Error", _forgetPasswordController.message!);
    }
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
                      validator: (String? value) {
                        String email = value?.trim() ?? '';
                        RegExp regEx = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (regEx.hasMatch(email) == false) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 25),
                    GetBuilder<ForgetPasswordController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.getTheEmailVerifiedInProcess == false,
                          replacement: const CircularProgressIndicator(),
                          child: ElevatedButton(
                            onPressed: () => _onTapNextButton(),
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 32,
                              color: AppColor.whiteColor,
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

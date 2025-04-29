import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/presentation/controllers/reset_password_controller.dart';
import 'package:to_do_application/presentation/controllers/show_password_controller.dart';
import 'package:to_do_application/presentation/widgets/center_circular_indicator_widget.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.userEmail,
    required this.userOTP,
  });

  final String userEmail;
  final String userOTP;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController = TextEditingController();
  final TextEditingController _confirmNewPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ResetPasswordController _resetPasswordController = Get.find<ResetPasswordController>();
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;

  void _onTapLogin() {
    Get.offAllNamed(RoutesName.login);
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _resetPassword();
    }
  }

  Future<void> _resetPassword() async {
    final isResetSuccess = await _resetPasswordController.resetPassword(
      widget.userEmail,
      widget.userOTP,
      _newPasswordTEController.text.trim(),
      _confirmNewPasswordTEController.text.trim(),
    );
    if (isResetSuccess) {
      Utils.toastMessage(_resetPasswordController.message!);
      _allClear();
      Get.offAllNamed(RoutesName.login);
    } else {
      Utils.toastMessage(_resetPasswordController.message!);
    }
  }

  _allClear() {
    _newPasswordTEController.clear();
    _confirmNewPasswordTEController.clear();
  }

  @override
  void dispose() {
    _newPasswordTEController.dispose();
    _confirmNewPasswordTEController.dispose();
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
                      AppStrings.setPassword,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppStrings.resetPassInstructions,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 28),
                    GetBuilder<ShowPasswordController>(
                      builder: (controller) {
                        return TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _newPasswordTEController,
                          obscureText: controller.obscurePassword,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            hintText: AppStrings.newPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off_outlined,
                                color: controller.obscurePassword
                                    ? AppColor.primaryColor
                                    : AppColor.greyColor,
                              ),
                              onPressed: controller.toggleObscure,
                            ),
                          ),
                          validator: (String? value) {
                            if ((value?.isEmpty ?? true) || value!.length < 6) {
                              return 'Please enter password with at least 6 letters';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    GetBuilder<ShowPasswordController>(
                      builder: (controller) {
                        return TextFormField(
                          controller: _confirmNewPasswordTEController,
                          obscureText: controller.obscurePassword,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            hintText: AppStrings.confirmNewPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off_outlined,
                                color: controller.obscurePassword
                                    ? AppColor.primaryColor
                                    : AppColor.greyColor,
                              ),
                              onPressed: controller.toggleObscure,
                            ),
                          ),
                          validator: (String? value) {
                            if ((value?.isEmpty ?? true) || value!.length < 6) {
                              return 'Please enter password with at least 6 letters';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    GetBuilder<ResetPasswordController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.reSetInProgress == false,
                          replacement: CenterCircularIndicatorWidget(),
                          child: ElevatedButton(
                            onPressed: () => _onTapSubmitButton(),
                            child: Text(
                              AppStrings.submit,
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

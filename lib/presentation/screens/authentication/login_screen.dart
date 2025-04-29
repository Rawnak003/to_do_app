import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/presentation/controllers/login_controller.dart';
import 'package:to_do_application/presentation/controllers/show_password_controller.dart';
import 'package:to_do_application/presentation/widgets/center_circular_indicator_widget.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final LoginController _loginController = Get.find<LoginController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  void _onTapLogin() {
    if (_formKey.currentState!.validate()) {
      _loginUser();
    }
  }

  Future<void> _loginUser() async {
    final bool isLoginSuccess = await _loginController.loginUser(
      _emailTEController.text.trim(),
      _passwordTEController.text,
    );
    if (isLoginSuccess) {
      Utils.toastMessage(_loginController.message!);
      _allClear();
      Get.offAllNamed(RoutesName.mainBottomNav);
    } else {
      Utils.toastMessage(_loginController.message!);
    }
  }

  _allClear() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapRegister() {
    Get.toNamed(RoutesName.register);
  }

  void _onTapForgetPassword() {
    Get.toNamed(RoutesName.forgetPassword);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
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
                      AppStrings.login,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      textInputAction: TextInputAction.next,
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
                    const SizedBox(height: 10),
                    GetBuilder<ShowPasswordController>(
                      builder: (controller) {
                        return TextFormField(
                          controller: _passwordTEController,
                          obscureText: controller.obscurePassword,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            hintText: AppStrings.password,
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
                    GetBuilder<LoginController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.loginInProgress == false,
                          replacement: CenterCircularIndicatorWidget(),
                          child: ElevatedButton(
                            onPressed: () => _onTapLogin(),
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 32,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 35),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () => _onTapForgetPassword(),
                          child: Text(
                            AppStrings.forgetPassword,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: AppStrings.dontHaveAccount,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              TextSpan(
                                text: AppStrings.register,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () => _onTapRegister(),
                              ),
                            ],
                          ),
                        ),
                      ],
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/data/models/auth_model.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';
import 'package:to_do_application/presentation/controllers/auth_controller.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginInProgress = false;
  bool obscurePassword = true;

  void _onTapLogin() {
    if (_formKey.currentState!.validate()) {
      _loginUser();
    }
  }

  Future<void> _loginUser() async {
    if (!mounted) return;
    setState(() {
      _loginInProgress = true;
    });

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: AppURLs.loginURL,
      body: requestBody,
    );

    if (!mounted) return;
    setState(() {
      _loginInProgress = false;
    });

    if (response.isSuccess) {
      AuthModel authModel = AuthModel.fromJson(response.data!);
      AuthController.saveUserInfo(authModel.accessToken, authModel.userModel);

      Utils.toastMessage("Login Successful!");
      _allClear();
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.mainBottomNav,
        (pre) => false,
      );
    } else {
      Utils.toastMessage("Login Failed!");
    }
  }

  _allClear() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapRegister() {
    Navigator.pushNamed(context, RoutesName.register);
  }

  void _onTapForgetPassword() {
    Navigator.pushNamed(context, RoutesName.forgetPassword);
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
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: obscurePassword,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        hintText: AppStrings.password,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off_outlined,
                            color: obscurePassword ? AppColor.primaryColor : AppColor.greyColor,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (String? value) {
                        if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                          return 'Please enter password with at least 6 letters';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 25),
                    Visibility(
                      visible: _loginInProgress == false,
                      replacement: CenterCircularIndicatorWidget(),
                      child: ElevatedButton(
                        onPressed: () => _onTapLogin(),
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 32,
                          color: AppColor.whiteColor,
                        ),
                      ),
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/presentation/widgets/center_circular_indicator_widget.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController =
      TextEditingController();
  final TextEditingController _confirmNewPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _resetInProgress = false;
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;

  void _onTapLogin() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.login,
      (pre) => false,
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _resetPassword();
    }
  }

  Future<void> _resetPassword() async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.login,
          (pre) => false,
    );
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
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _newPasswordTEController,
                      obscureText: obscurePassword1,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        hintText: AppStrings.newPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword1
                                ? Icons.visibility_off_outlined
                                : Icons.visibility,
                            color: obscurePassword1 ? AppColor.greyColor : AppColor.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword1 = !obscurePassword1;
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
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _confirmNewPasswordTEController,
                      obscureText: obscurePassword2,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        hintText: AppStrings.confirmNewPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword2
                                ? Icons.visibility_off_outlined
                                : Icons.visibility,
                            color: obscurePassword2 ? AppColor.greyColor : AppColor.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword2 = !obscurePassword2;
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
                      visible: _resetInProgress == false,
                      replacement: CenterCircularIndicatorWidget(),
                      child: ElevatedButton(
                        onPressed: () => _onTapSubmitButton(),
                        child: Text(
                          AppStrings.submit,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
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

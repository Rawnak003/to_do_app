import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/presentation/screens/authentication/login_screen.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final TextEditingController _newPasswordTEController = TextEditingController();
  final TextEditingController _confirmNewPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onTapLogin(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (pre) => false);
  }

  void _onTapSubmitButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (pre) => false);
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
                      decoration: InputDecoration(hintText: AppStrings.newPassword),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _confirmNewPasswordTEController,
                      decoration: InputDecoration(hintText: AppStrings.confirmNewPassword),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () => _onTapSubmitButton(),
                      child: Text(
                        AppStrings.submit,
                        style: Theme.of(context).textTheme.titleMedium,
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

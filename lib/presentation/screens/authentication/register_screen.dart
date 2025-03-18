import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onTapLogin(){
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.login,
          (pre) => false,
    );
  }

  void _onTapSubmitButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.login,
          (pre) => false,
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneTEController.dispose();
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
                      AppStrings.register,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: AppStrings.email),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _firstNameTEController,
                      decoration: InputDecoration(hintText: AppStrings.firstName),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _lastNameTEController,
                      decoration: InputDecoration(hintText: AppStrings.lastName),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      controller: _phoneTEController,
                      decoration: InputDecoration(hintText: AppStrings.phone),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: AppStrings.password),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () => _onTapSubmitButton(),
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 32,
                        color: AppColor.whiteColor,
                      ),
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

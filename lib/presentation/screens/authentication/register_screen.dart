import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';
import 'package:to_do_application/presentation/widgets/center_circular_indicator_widget.dart';
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
  bool registrationInProgress = false;

  void _onTapLogin(){
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.login,
          (pre) => false,
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _registerUser();
    }
  }

  Future<void> _registerUser() async {
    if (!mounted) return;
    setState(() {
      registrationInProgress = true;
    });

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: AppURLs.registerURL,
      body: requestBody,
    );

    if (!mounted) return;
    setState(() {
      registrationInProgress = false;
    });

    if (response.isSuccess) {
      Utils.toastMessage("Registration Successful!");
      _allClear();
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.login,
            (pre) => false,
      );
    } else {
      Utils.toastMessage("Registration Failed!");
    }
  }

  _allClear(){
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _phoneTEController.clear();
    _passwordTEController.clear();
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
                      validator: (String? value) {
                        String email = value?.trim() ?? '';
                        RegExp regEx = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                        if (regEx.hasMatch(email) == false) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _firstNameTEController,
                      decoration: InputDecoration(hintText: AppStrings.firstName),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter first name';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _lastNameTEController,
                      decoration: InputDecoration(hintText: AppStrings.lastName),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter last name';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      controller: _phoneTEController,
                      decoration: InputDecoration(hintText: AppStrings.phone),
                      validator: (String? value) {
                        String phone = value?.trim() ?? '';
                        RegExp regExp = RegExp(r'^(?:\+8801|01)[3-9]\d{8}$');
                        if (regExp.hasMatch(phone) == false) {
                          return 'Please enter valid phone number';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: AppStrings.password),
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
                      visible: registrationInProgress == false,
                      replacement: CenterCircularIndicatorWidget(),
                      child: ElevatedButton(
                        onPressed: () => _onTapSubmitButton(),
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 32,
                          color: AppColor.whiteColor,
                        ),
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


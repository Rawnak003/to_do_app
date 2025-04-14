import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/spacing.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/data/models/user_model.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';
import 'package:to_do_application/presentation/controllers/auth_controller.dart';
import 'package:to_do_application/presentation/widgets/center_circular_indicator_widget.dart';
import 'package:to_do_application/presentation/widgets/custom_app_bar.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _oldPasswordTEController = TextEditingController();
  final TextEditingController _newPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  bool userDetailsUpdateInProgress1 = false;
  bool userDetailsUpdateInProgress2 = false;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;

  _onTapUpdateDetailsButton() {
    if(_formKey1.currentState!.validate()) {
      _userProfileUpdate();
    }
  }

  _onTapUpdatePasswordButton() {
    if(_formKey2.currentState!.validate()) {
      _updatePassword();
    }
  }

  Future<void> _userProfileUpdate() async {
    if (!mounted) return;
    setState(() {
      userDetailsUpdateInProgress1 = true;
    });

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
    };

    if (_pickedImage != null) {
      List<int> imageBytes = await _pickedImage!.readAsBytes();
      String encodedImage = base64Encode(imageBytes);
      requestBody["photo"] = encodedImage;
    }

    NetworkResponse response = await NetworkClient.postRequest(
      url: AppURLs.profileUpdateURL,
      body: requestBody,
    );

    if (!mounted) return;
    setState(() {
      userDetailsUpdateInProgress1 = false;
    });

    if (response.isSuccess) {
      await AuthController.saveUpdatedUserDetailsToPrefsWithoutPassword(requestBody);
      Navigator.pop(context, true);
      Utils.toastMessage("Update Successful!");
    } else {
      Utils.toastMessage("Update Failed!");
    }
  }

  Future<void> _updatePassword() async {
    if (!mounted) return;
    setState(() {
      userDetailsUpdateInProgress2 = true;
    });

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
    };

    if (_pickedImage != null) {
      List<int> imageBytes = await _pickedImage!.readAsBytes();
      String encodedImage = base64Encode(imageBytes);
      requestBody["photo"] = encodedImage;
    }

    if(_oldPasswordTEController.text.isNotEmpty && _newPasswordTEController.text.isNotEmpty) {
      String? userOldPassword = await AuthController.getUserPass();
      if(_oldPasswordTEController.text != userOldPassword) {
        Utils.snackBar("Old password is incorrect! Please try again.", context);
      } else if(_oldPasswordTEController.text == _newPasswordTEController.text) {
        Utils.snackBar("Same as old password! Please try different password.", context);
      } else {
        requestBody["password"] = _newPasswordTEController.text;
      }
    }

    NetworkResponse response = await NetworkClient.postRequest(
      url: AppURLs.profileUpdateURL,
      body: requestBody,
    );

    if (!mounted) return;
    setState(() {
      userDetailsUpdateInProgress2 = false;
    });

    if (response.isSuccess) {
      await AuthController.saveUpdatedUserDetailsToPrefsWithPassword(requestBody);
      Navigator.pop(context, true);
      _oldPasswordTEController.clear();
      _newPasswordTEController.clear();
      Utils.toastMessage("Password Update Successful!");
    } else {
      Utils.toastMessage("Password Update Failed!");
    }
  }

  @override
  void initState() {
    super.initState();
    UserModel userModel = AuthController.userModel!;
    _emailTEController.text = userModel.email;
    _firstNameTEController.text = userModel.firstName;
    _lastNameTEController.text = userModel.lastName;
    _phoneTEController.text = userModel.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: CustomAppBar(fromProfile: true,),
        body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.updateProfile,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 26),
                          ),
                          const SizedBox(height: 28),
                          _buildPhotoPickerWidget(context),
                          const SizedBox(height: 10),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            enabled: false,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailTEController,
                            decoration: InputDecoration(hintText: AppStrings.email),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _firstNameTEController,
                            decoration: InputDecoration(
                              hintText: AppStrings.firstName,
                            ),
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
                            decoration: InputDecoration(
                              hintText: AppStrings.lastName,
                            ),
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
                          const SizedBox(height: 15),
                          Visibility(
                            visible: userDetailsUpdateInProgress1 == false,
                            replacement: const CenterCircularIndicatorWidget(),
                            child: ElevatedButton(
                              onPressed: () => _onTapUpdateDetailsButton(),
                              child: const Icon(
                                Icons.arrow_circle_right_outlined,
                                size: 32,
                                color: AppColor.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(color: AppColor.greyColor, thickness: 1,),
                    const SizedBox(height: 10),
                    Form(
                      key: _formKey2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.updatePassword,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 26),
                          ),
                          const SizedBox(height: 28),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _oldPasswordTEController,
                            decoration: InputDecoration(
                              hintText: AppStrings.oldPassword,
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
                            controller: _newPasswordTEController,
                            decoration: InputDecoration(
                              hintText: AppStrings.newPassword,
                            ),
                            validator: (String? value) {
                              if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                                return 'Please enter password with at least 6 letters';
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(height: 15),
                          Visibility(
                            visible: userDetailsUpdateInProgress2 == false,
                            replacement: const CenterCircularIndicatorWidget(),
                            child: ElevatedButton(
                              onPressed: () => _onTapUpdatePasswordButton(),
                              child: const Icon(
                                Icons.arrow_circle_right_outlined,
                                size: 32,
                                color: AppColor.whiteColor,
                              ),
                            ),
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

  Widget _buildPhotoPickerWidget(BuildContext context) {
    return InkWell(
      onTap: _onTapPhotoPicker,
      child: Container(
        height: AppSpacing.screenHeight(context) * 0.06,
        width: AppSpacing.screenWidth(context),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: AppSpacing.screenHeight(context) * 0.06,
              width: AppSpacing.screenWidth(context) * 0.18,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                AppStrings.photo,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              _pickedImage?.name ?? AppStrings.selectPhoto,
              style: TextStyle(
                fontSize: 16,
                color: AppColor.greyColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapPhotoPicker() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _pickedImage = image;
      setState(() {});
    }
  }
}

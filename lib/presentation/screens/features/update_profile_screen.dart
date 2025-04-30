import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/spacing.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/data/models/user_model.dart';
import 'package:to_do_application/presentation/controllers/auth_controller.dart';
import 'package:to_do_application/presentation/controllers/image_picker_controller.dart';
import 'package:to_do_application/presentation/controllers/user_password_update_controller.dart';
import 'package:to_do_application/presentation/controllers/user_profile_update_controller.dart';
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
  final TextEditingController _oldPasswordTEController =
      TextEditingController();
  final TextEditingController _newPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final ImagePickerController _photoController =
      Get.find<ImagePickerController>();

  final UserProfileUpdateController _userProfileUpdateController =
      Get.find<UserProfileUpdateController>();
  final UserPasswordUpdateController _userPasswordUpdateController =
      Get.find<UserPasswordUpdateController>();

  _onTapUpdateDetailsButton() {
    if (_formKey1.currentState!.validate()) {
      _userProfileUpdate();
    }
  }

  _onTapUpdatePasswordButton() {
    if (_formKey2.currentState!.validate()) {
      _updatePassword();
    }
  }

  Future<void> _userProfileUpdate() async {
    final bool isSuccessful = await _userProfileUpdateController
        .userProfileUpdate(
          _emailTEController.text.trim(),
          _firstNameTEController.text.trim(),
          _lastNameTEController.text.trim(),
          _phoneTEController.text.trim(),
          _photoController,
        );
    if (isSuccessful) {
      Get.back(result: true);
      Utils.toastMessage(_userProfileUpdateController.message!);
    } else {
      Utils.toastMessage(_userProfileUpdateController.message!);
    }
  }

  Future<void> _updatePassword() async {
    final bool isSuccessful = await _userPasswordUpdateController.userPasswordUpdate(
      _emailTEController.text.trim(),
      _firstNameTEController.text.trim(),
      _lastNameTEController.text.trim(),
      _phoneTEController.text.trim(),
      _photoController,
      _oldPasswordTEController.text.trim(),
      _newPasswordTEController.text.trim(),
    );

    if (isSuccessful) {
      Get.back(result: true);
      _oldPasswordTEController.clear();
      _newPasswordTEController.clear();
      Utils.toastMessage(_userPasswordUpdateController.message!);
    } else {
      Utils.toastMessage(_userPasswordUpdateController.message!);
    }
  }

  void _onTapPhotoPicker() {
    _photoController.pickImage();
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
        appBar: CustomAppBar(fromProfile: true),
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
                            style: Theme.of(
                              context,
                            ).textTheme.headlineMedium?.copyWith(fontSize: 26),
                          ),
                          const SizedBox(height: 28),
                          _buildPhotoPickerWidget(context),
                          const SizedBox(height: 10),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            enabled: false,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailTEController,
                            decoration: InputDecoration(
                              hintText: AppStrings.email,
                            ),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneTEController,
                            decoration: InputDecoration(
                              hintText: AppStrings.phone,
                            ),
                            validator: (String? value) {
                              String phone = value?.trim() ?? '';
                              RegExp regExp = RegExp(
                                r'^(?:\+8801|01)[3-9]\d{8}$',
                              );
                              if (regExp.hasMatch(phone) == false) {
                                return 'Please enter valid phone number';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(height: 15),
                          GetBuilder<UserProfileUpdateController>(
                            builder: (controller) {
                              return Visibility(
                                visible:
                                    controller.userDetailsUpdateInProgress ==
                                    false,
                                replacement:
                                    const CenterCircularIndicatorWidget(),
                                child: ElevatedButton(
                                  onPressed: () => _onTapUpdateDetailsButton(),
                                  child: const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    size: 32,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(color: AppColor.greyColor, thickness: 1),
                    const SizedBox(height: 10),
                    Form(
                      key: _formKey2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.updatePassword,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineMedium?.copyWith(fontSize: 26),
                          ),
                          const SizedBox(height: 28),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _oldPasswordTEController,
                            decoration: InputDecoration(
                              hintText: AppStrings.oldPassword,
                            ),
                            validator: (String? value) {
                              if ((value?.isEmpty ?? true) ||
                                  (value!.length < 6)) {
                                return 'Please enter password with at least 6 letters';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _newPasswordTEController,
                            decoration: InputDecoration(
                              hintText: AppStrings.newPassword,
                            ),
                            validator: (String? value) {
                              if ((value?.isEmpty ?? true) ||
                                  (value!.length < 6)) {
                                return 'Please enter password with at least 6 letters';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(height: 15),
                          GetBuilder<UserPasswordUpdateController>(
                            builder: (controller) {
                              return Visibility(
                                visible: controller.userPasswordUpdateInProgress == false,
                                replacement: const CenterCircularIndicatorWidget(),
                                child: ElevatedButton(
                                  onPressed: () => _onTapUpdatePasswordButton(),
                                  child: const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    size: 32,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              );
                            }
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
            Obx(() {
              final pickedImage = _photoController.pickedImage.value;
              return Text(
                pickedImage?.name ?? AppStrings.selectPhoto,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.greyColor,
                  fontWeight: FontWeight.w400,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

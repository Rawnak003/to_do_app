import 'dart:convert';
import 'package:get/get.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';
import 'package:to_do_application/presentation/controllers/auth_controller.dart';
import 'package:to_do_application/presentation/controllers/image_picker_controller.dart';

class UserPasswordUpdateController extends GetxController {
  bool _userPasswordUpdateInProgress = false;
  String? _message;

  bool get userPasswordUpdateInProgress => _userPasswordUpdateInProgress;
  String? get message => _message;

  Future<bool> userPasswordUpdate(String email, String firstName, String lastName, String mobile, ImagePickerController photoController, String oldPassword, String newPassword) async {
    bool isSuccess = false;
    _userPasswordUpdateInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (photoController.pickedImage.value != null) {
      List<int> imageBytes = await photoController.pickedImage.value!.readAsBytes();
      String encodedImage = base64Encode(imageBytes);
      requestBody["photo"] = encodedImage;
    }

    if (oldPassword.isNotEmpty &&
        newPassword.isNotEmpty) {
      String? userOldPassword = await AuthController.getUserPass();

      if (oldPassword != userOldPassword) {
        Get.snackbar(
          "Error",
          "Old password is incorrect! Please try again.",
        );
        _userPasswordUpdateInProgress = false;
        update();
        return isSuccess;
      }

      if (oldPassword == newPassword) {
        Get.snackbar(
          "Error",
          "Same as old password! Please try a different password.",
        );
        _userPasswordUpdateInProgress = false;
        update();
        return isSuccess;
      }
      requestBody["password"] = newPassword;
    }

    NetworkResponse response = await NetworkClient.postRequest(
      url: AppURLs.profileUpdateURL,
      body: requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
      await AuthController.saveUpdatedUserDetailsToPrefsWithPassword(
        requestBody,
      );
      _message = "Update Successful!";
    } else {
      _message = "Update Failed!";
    }

    _userPasswordUpdateInProgress = false;
    update();
    return isSuccess;
  }
}
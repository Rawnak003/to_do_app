import 'dart:convert';
import 'package:get/get.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';
import 'package:to_do_application/presentation/controllers/auth_controller.dart';
import 'package:to_do_application/presentation/controllers/image_picker_controller.dart';

class UserProfileUpdateController extends GetxController {
  bool _userDetailsUpdateInProgress = false;
  String? _message;

  bool get userDetailsUpdateInProgress => _userDetailsUpdateInProgress;
  String? get message => _message;

  Future<bool> userProfileUpdate(String email, String firstName, String lastName, String mobile, ImagePickerController photoController) async {
    bool isSuccess = false;
    _userDetailsUpdateInProgress = true;
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

    NetworkResponse response = await NetworkClient.postRequest(
      url: AppURLs.profileUpdateURL,
      body: requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
      await AuthController.saveUpdatedUserDetailsToPrefsWithoutPassword(requestBody);
      _message = "Update Successful!";
    } else {
      _message = "Update Failed!";
    }

    _userDetailsUpdateInProgress = false;
    update();
    return isSuccess;
  }
}


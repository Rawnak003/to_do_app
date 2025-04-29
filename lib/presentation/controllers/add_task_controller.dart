import 'package:get/get.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';

class AddTaskController extends GetxController {
  bool _addTaskInProgress = false;
  String? _message;

  bool get addTaskInProgress => _addTaskInProgress;
  String? get message => _message;

  Future<bool> addTask(String title, String description) async {
    bool isSuccess = false;
    _addTaskInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: AppURLs.addNewTaskURL,
      body: requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
      _message = "New Task Added!";
    } else {
      _message = "Adding Failed!";
    }

    _addTaskInProgress = false;
    update();
    return isSuccess;
  }
}
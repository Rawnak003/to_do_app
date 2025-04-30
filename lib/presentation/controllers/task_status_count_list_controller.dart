import 'package:get/get.dart';
import 'package:to_do_application/data/models/task_count_list_model.dart';
import 'package:to_do_application/data/models/task_count_model.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';

class TaskStatusCountListController extends GetxController {
  String? _message;
  bool _getTaskCountInProgress = false;
  List<TaskCountModel> _taskCountList = [];

  bool get getTaskCountInProgress => _getTaskCountInProgress;
  String? get message => _message;
  List<TaskCountModel> get taskCountList => _taskCountList;

  Future<bool> getAllTaskStatusCount() async {
    bool isGetTaskStatusCountSuccess = false;
    _getTaskCountInProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.taskStatusCountURL,
    );

    if (response.isSuccess) {
      TaskCountListModel taskCountListModel = TaskCountListModel.fromJson(
        response.data ?? {},
      );
      _taskCountList = taskCountListModel.countList;
      isGetTaskStatusCountSuccess = true;
      _message = "";
    } else {
      _message = response.message;
    }

    _getTaskCountInProgress = false;
    update();
    return isGetTaskStatusCountSuccess;
  }
}
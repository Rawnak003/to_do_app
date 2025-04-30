import 'package:get/get.dart';
import 'package:to_do_application/data/models/task_list_model.dart';
import 'package:to_do_application/data/models/task_model.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';

class ProgressTaskListController extends GetxController {
  String? _message;
  List<TaskModel> _progressTaskList = [];
  bool _getProgressTaskListInProgress = false;

  bool get getProgressTaskListInProgress => _getProgressTaskListInProgress;
  String? get message => _message;
  List<TaskModel> get progressTaskList => _progressTaskList;

  Future<bool> getProgressTaskList() async {
    bool isGetProgressTaskListSuccess = false;
    _getProgressTaskListInProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.taskListURL('Progress'),
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _progressTaskList = taskListModel.taskList;
      isGetProgressTaskListSuccess = true;
      _message = "";
    } else {
      _message = response.message;
    }

    _getProgressTaskListInProgress = false;
    update();
    return isGetProgressTaskListSuccess;
  }
}

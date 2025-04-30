import 'package:get/get.dart';
import 'package:to_do_application/data/models/task_list_model.dart';
import 'package:to_do_application/data/models/task_model.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';

class CompletedTaskListController extends GetxController {
  String? _message;
  List<TaskModel> _completedTaskList = [];
  bool _getCompletedTaskListInProgress = false;

  bool get getCompletedTaskListInProgress => _getCompletedTaskListInProgress;

  String? get message => _message;

  List<TaskModel> get completedTaskList => _completedTaskList;

  Future<bool> getCompletedTaskList() async {
    bool isGetCompletedTaskListSuccess = false;
    _getCompletedTaskListInProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.taskListURL('Completed'),
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _completedTaskList = taskListModel.taskList;
      isGetCompletedTaskListSuccess = true;
      _message = "";
    } else {
      _message = response.message;
    }

    _getCompletedTaskListInProgress = false;
    update();
    return isGetCompletedTaskListSuccess;
  }
}

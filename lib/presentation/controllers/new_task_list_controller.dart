import 'package:get/get.dart';
import 'package:to_do_application/data/models/task_list_model.dart';
import 'package:to_do_application/data/models/task_model.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';

class NewTaskListController extends GetxController {
  String? _message;
  List<TaskModel> _newTaskList = [];
  bool _getNewTaskListInProgress = false;

  bool get getNewTaskListInProgress => _getNewTaskListInProgress;
  String? get message => _message;
  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getNewTaskList() async {
    bool isGetNewTaskListSuccess = false;
    _getNewTaskListInProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.taskListURL('New'),
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _newTaskList = taskListModel.taskList;
      isGetNewTaskListSuccess = true;
      _message = "";
    } else {
      _message = response.message;
    }

    _getNewTaskListInProgress = false;
    update();
    return isGetNewTaskListSuccess;
  }
}
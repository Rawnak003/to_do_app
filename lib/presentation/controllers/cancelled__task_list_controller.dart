import 'package:get/get.dart';
import 'package:to_do_application/data/models/task_list_model.dart';
import 'package:to_do_application/data/models/task_model.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';

class CancelledTaskListController extends GetxController {
  String? _message;
  List<TaskModel> _cancelledTaskList = [];
  bool _getCancelledTaskListInProgress = false;

  bool get getCancelledTaskListInProgress => _getCancelledTaskListInProgress;

  String? get message => _message;

  List<TaskModel> get cancelledTaskList => _cancelledTaskList;

  Future<bool> getCancelledTaskList() async {
    bool isGetCancelledTaskListSuccess = false;
    _getCancelledTaskListInProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.taskListURL('Cancelled'),
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _cancelledTaskList = taskListModel.taskList;
      isGetCancelledTaskListSuccess = true;
      _message = "";
    } else {
      _message = response.message;
    }

    _getCancelledTaskListInProgress = false;
    update();
    return isGetCancelledTaskListSuccess;
  }
}

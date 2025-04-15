import 'package:to_do_application/data/models/task_model.dart';

class TaskListModel {
  late final List<TaskModel> taskList;
  late final String status;

  TaskListModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'] ?? '';
    if(jsonData['data'] != null) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> data in jsonData['data']) {
        list.add(TaskModel.fromJson(data));
      }
      taskList = list;
    } else {
      taskList = [];
    }
  }
}
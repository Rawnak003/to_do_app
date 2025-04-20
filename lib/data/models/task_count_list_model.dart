import 'package:to_do_application/data/models/task_count_model.dart';

class TaskCountListModel {
  late final List<TaskCountModel> countList;
  late final String status;

  TaskCountListModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'] ?? '';
    if(jsonData['data'] != null) {
      List<TaskCountModel> list = [];
      for (Map<String, dynamic> data in jsonData['data']) {
        list.add(TaskCountModel.fromJson(data));
      }
      countList = list;
    } else {
      countList = [];
    }
  }
}
class TaskCountModel {
  final int taskCount;
  final String taskStatus;

  TaskCountModel({
    required this.taskCount,
    required this.taskStatus,
  });

  factory TaskCountModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskCountModel(
      taskCount: jsonData['sum'] ?? 0,
      taskStatus: jsonData['_id'],
    );
  }

}
import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/data/models/task_list_model.dart';
import 'package:to_do_application/data/models/task_model.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';
import 'package:to_do_application/presentation/widgets/task_card_widget.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskListInProgress = false;
  List<TaskModel> _completedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  Future<void> _getCompletedTaskList() async {
    if (!mounted) return;
    setState(() {
      _getCompletedTaskListInProgress = true;
    });

    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.taskListURL('Completed'),
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _completedTaskList = taskListModel.taskList;
    } else {
      Utils.snackBar(response.message, context);
    }

    if (!mounted) return;
    setState(() {
      _getCompletedTaskListInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: _getCompletedTaskListInProgress == false,
          replacement: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(child: const CircularProgressIndicator()),
          ),
          child: Expanded(
            child: ListView.separated(
              itemCount: _completedTaskList.length,
              itemBuilder:
                  (context, index) => TaskCard(
                    title: _completedTaskList[index].title,
                    subtitle: _completedTaskList[index].description,
                    date: _completedTaskList[index].createdDate,
                    status: TaskStatus.completedTask,
                    index: index,
                    taskId: _completedTaskList[index].id,
                    refreshList: _getCompletedTaskList,
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
            ),
          ),
        ),
      ),
    );
  }
}

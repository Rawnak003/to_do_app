import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/data/models/task_list_model.dart';
import 'package:to_do_application/data/models/task_model.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';
import 'package:to_do_application/presentation/widgets/task_card_widget.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskListInProgress = false;
  List<TaskModel> _progressTaskList = [];

  @override
    void initState() {
      super.initState();
      _getProgressTaskList();
    }

  Future<void> _getProgressTaskList() async {
    if (!mounted) return;
    setState(() {
      _getProgressTaskListInProgress = true;
    });

    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.taskListURL('Progress'),
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _progressTaskList = taskListModel.taskList;
    } else {
      Utils.snackBar(response.message, context);
    }

    if (!mounted) return;
    setState(() {
      _getProgressTaskListInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: _getProgressTaskListInProgress == false,
          replacement: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(child: const CircularProgressIndicator()),
          ),
          child: Expanded(
            child: ListView.separated(
              itemCount: _progressTaskList.length,
              itemBuilder:
                  (context, index) => TaskCard(
                    title: _progressTaskList[index].title,
                    subtitle: _progressTaskList[index].description,
                    date: _progressTaskList[index].createdDate,
                    status: TaskStatus.progressTask,
                    index: index,
                    taskId: _progressTaskList[index].id,
                    refreshList: _getProgressTaskList,
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/data/models/task_list_model.dart';
import 'package:to_do_application/data/models/task_model.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';
import 'package:to_do_application/presentation/widgets/task_card_widget.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskListInProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  Future<void> _getCancelledTaskList() async {
    if (!mounted) return;
    setState(() {
      _getCancelledTaskListInProgress = true;
    });

    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.taskListURL('Cancelled'),
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _cancelledTaskList = taskListModel.taskList;
    } else {
      Utils.snackBar(response.message, context);
    }

    if (!mounted) return;
    setState(() {
      _getCancelledTaskListInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: _getCancelledTaskListInProgress == false,
          replacement: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(child: const CircularProgressIndicator()),
          ),
          child: Expanded(
            child: ListView.separated(
              itemCount: _cancelledTaskList.length,
              itemBuilder:
                  (context, index) => TaskCard(
                    title: _cancelledTaskList[index].title,
                    subtitle: _cancelledTaskList[index].description,
                    date: _cancelledTaskList[index].createdDate,
                    status: TaskStatus.cancelledTask,
                    index: index,
                    taskId: _cancelledTaskList[index].id,
                    refreshList: _getCancelledTaskList,
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
            ),
          ),
        ),
      ),
    );
  }
}

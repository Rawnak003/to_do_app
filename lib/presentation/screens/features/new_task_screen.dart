import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/data/models/task_count_list_model.dart';
import 'package:to_do_application/data/models/task_count_model.dart';
import 'package:to_do_application/data/models/task_list_model.dart';
import 'package:to_do_application/data/models/task_model.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';
import 'package:to_do_application/presentation/widgets/details_show_card__widget.dart';
import 'package:to_do_application/presentation/widgets/task_card_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getTaskCountInProgress = false;
  List<TaskCountModel> _taskCountList = [];
  bool _getNewTaskListInProgress = false;
  List<TaskModel> _newTaskList = [];
  final ScrollController _scrollController = ScrollController();
  bool _showFAB = true;

  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
    _getNewTaskList();
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && _showFAB) {
        setState(() {
          _showFAB = false;
        });
      } else if (_scrollController.offset <= 0 && !_showFAB) {
        setState(() {
          _showFAB = true;
        });
      }
    });
  }

  Future<void> _getAllTaskStatusCount() async {
    if (!mounted) return;
    setState(() {
      _getTaskCountInProgress = true;
    });

    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.taskStatusCountURL,
    );

    if (response.isSuccess) {
      TaskCountListModel taskCountListModel = TaskCountListModel.fromJson(
        response.data ?? {},
      );
      _taskCountList = taskCountListModel.countList;
    } else {
      Utils.snackBar(response.message, context);
    }

    if (!mounted) return;
    setState(() {
      _getTaskCountInProgress = false;
    });
  }

  Future<void> _getNewTaskList() async {
    if (!mounted) return;
    setState(() {
      _getNewTaskListInProgress = true;
    });

    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.taskListURL('New'),
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _newTaskList = taskListModel.taskList;
    } else {
      Utils.snackBar(response.message, context);
    }

    if (!mounted) return;
    setState(() {
      _getNewTaskListInProgress = false;
    });
  }

  void _onTapAddTask() {
    Navigator.pushNamed(context, RoutesName.addTask);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      floatingActionButton:
          _showFAB
              ? FloatingActionButton(
                backgroundColor: AppColor.primaryColor,
                onPressed: () => _onTapAddTask(),
                child: Icon(Icons.add, size: 30, color: AppColor.whiteColor),
              )
              : null,

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Visibility(
              visible: _getTaskCountInProgress == false,
              replacement: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: const CircularProgressIndicator()),
              ),
              child: _taskStatusCountShow(),
            ),
            const SizedBox(height: 5),
            Visibility(
              visible: _getNewTaskListInProgress == false,
              replacement: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Center(child: const CircularProgressIndicator()),
              ),
              child: Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: _newTaskList.length,
                  itemBuilder:
                      (context, index) => TaskCard(
                        title: _newTaskList[index].title,
                        subtitle: _newTaskList[index].description,
                        date: _newTaskList[index].createdDate,
                        status: TaskStatus.newTask,
                        index: index,
                      ),
                  separatorBuilder: (context, index) => const SizedBox(height: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _taskStatusCountShow() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _taskCountList.length,
        itemBuilder: (context, index) {
          return DetailsShowCard(
            title: _taskCountList[index].taskStatus,
            count: _taskCountList[index].taskCount,
          );
        },
      ),
    );
  }
}

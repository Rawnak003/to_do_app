import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/presentation/controllers/new_task_list_controller.dart';
import 'package:to_do_application/presentation/controllers/task_status_count_list_controller.dart';
import 'package:to_do_application/presentation/widgets/details_show_card__widget.dart';
import 'package:to_do_application/presentation/widgets/task_card_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TaskStatusCountListController _taskStatusCountListController = Get.find<TaskStatusCountListController>();
  final NewTaskListController _newTaskListController = Get.find<NewTaskListController>();
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
    final bool isSuccessful = await _taskStatusCountListController.getAllTaskStatusCount();
    if (!isSuccessful) {
      Get.snackbar("Error", _taskStatusCountListController.message!);
    }
  }

  Future<void> _getNewTaskList() async {
    final bool isSuccessful = await _newTaskListController.getNewTaskList();
    if (!isSuccessful) {
      Get.snackbar("Error", _newTaskListController.message!);
    }
  }

  Future<void> _onTapAddTask() async {
    final isAdded = await Get.toNamed(RoutesName.addTask);
    if (isAdded == true) {
      setState(() {
        _getNewTaskList();
        _getAllTaskStatusCount();
      });
    }
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
            GetBuilder<TaskStatusCountListController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.getTaskCountInProgress == false,
                  replacement: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(child: const CircularProgressIndicator()),
                  ),
                  child: _taskStatusCountShow(),
                );
              }
            ),
            const SizedBox(height: 5),
            GetBuilder<NewTaskListController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.getNewTaskListInProgress == false,
                  replacement: Padding(
                    padding: const EdgeInsets.only(top: 300),
                    child: Center(child: const CircularProgressIndicator()),
                  ),
                  child: Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: controller.newTaskList.length,
                      itemBuilder:
                          (context, index) => TaskCard(
                            title: controller.newTaskList[index].title,
                            subtitle: controller.newTaskList[index].description,
                            date: controller.newTaskList[index].createdDate,
                            status: TaskStatus.newTask,
                            index: index,
                            taskId: controller.newTaskList[index].id,
                            refreshList: _getNewTaskList,
                            refreshStatusCount: _getAllTaskStatusCount,
                          ),
                      separatorBuilder: (context, index) => const SizedBox(height: 2),
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _taskStatusCountShow() {
    return GetBuilder<TaskStatusCountListController>(
      builder: (controller) {
        return SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.taskCountList.length,
            itemBuilder: (context, index) {
              return DetailsShowCard(
                title: controller.taskCountList[index].taskStatus,
                count: controller.taskCountList[index].taskCount,
              );
            },
          ),
        );
      }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/presentation/controllers/completed_task_list_controller.dart';
import 'package:to_do_application/presentation/widgets/task_card_widget.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskListController _completedTaskListController = Get.find<CompletedTaskListController>();

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  Future<void> _getCompletedTaskList() async {
    final bool isSuccessful = await _completedTaskListController.getCompletedTaskList();
    if (!isSuccessful) {
      Get.snackbar("Error", _completedTaskListController.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<CompletedTaskListController>(
          builder: (controller) {
            return Visibility(
              visible: controller.getCompletedTaskListInProgress == false,
              replacement: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(child: const CircularProgressIndicator()),
              ),
              child: Expanded(
                child: ListView.separated(
                  itemCount: controller.completedTaskList.length,
                  itemBuilder:
                      (context, index) => TaskCard(
                        title: controller.completedTaskList[index].title,
                        subtitle: controller.completedTaskList[index].description,
                        date: controller.completedTaskList[index].createdDate,
                        status: TaskStatus.completedTask,
                        index: index,
                        taskId: controller.completedTaskList[index].id,
                        refreshList: _getCompletedTaskList,
                      ),
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

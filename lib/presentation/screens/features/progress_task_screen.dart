import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/presentation/controllers/progress_task_list_controller.dart';
import 'package:to_do_application/presentation/widgets/task_card_widget.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTaskListController _progressTaskListController =
      Get.find<ProgressTaskListController>();

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }

  Future<void> _getProgressTaskList() async {
    final bool isSuccessful = await _progressTaskListController.getProgressTaskList();
    if (!isSuccessful) {
      Get.snackbar("Error", _progressTaskListController.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<ProgressTaskListController>(
          builder: (controller) {
            return Visibility(
              visible: controller.getProgressTaskListInProgress == false,
              replacement: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(child: const CircularProgressIndicator()),
              ),
              child: Expanded(
                child: ListView.separated(
                  itemCount: controller.progressTaskList.length,
                  itemBuilder:
                      (context, index) => TaskCard(
                        title: controller.progressTaskList[index].title,
                        subtitle: controller.progressTaskList[index].description,
                        date: controller.progressTaskList[index].createdDate,
                        status: TaskStatus.progressTask,
                        index: index,
                        taskId: controller.progressTaskList[index].id,
                        refreshList: _getProgressTaskList,
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

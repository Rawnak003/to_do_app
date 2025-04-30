import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/presentation/controllers/cancelled__task_list_controller.dart';
import 'package:to_do_application/presentation/widgets/task_card_widget.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskListController _cancelledTaskListController = Get.find<CancelledTaskListController>();

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  Future<void> _getCancelledTaskList() async {
    final bool isSuccessful = await _cancelledTaskListController.getCancelledTaskList();
    if (!isSuccessful) {
      Get.snackbar("Error", _cancelledTaskListController.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<CancelledTaskListController>(
          builder: (controller) {
            return Visibility(
              visible: controller.getCancelledTaskListInProgress == false,
              replacement: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(child: const CircularProgressIndicator()),
              ),
              child: Expanded(
                child: ListView.separated(
                  itemCount: controller.cancelledTaskList.length,
                  itemBuilder:
                      (context, index) => TaskCard(
                        title: controller.cancelledTaskList[index].title,
                        subtitle: controller.cancelledTaskList[index].description,
                        date: controller.cancelledTaskList[index].createdDate,
                        status: TaskStatus.cancelledTask,
                        index: index,
                        taskId: controller.cancelledTaskList[index].id,
                        refreshList: _getCancelledTaskList,
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

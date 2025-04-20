import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';

enum TaskStatus { newTask, progressTask, completedTask, cancelledTask }

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.status,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.index,
    required this.taskId,
    required this.refreshList,
    this.refreshStatusCount,
  });
  final String taskId;
  final TaskStatus status;
  final String title;
  final String subtitle;
  final String date;
  final int index;
  final VoidCallback refreshList;
  final VoidCallback? refreshStatusCount;

  Color _getChipColor() {
    late Color color;
    switch (status) {
      case TaskStatus.newTask:
        color = AppColor.blueColor;
      case TaskStatus.progressTask:
        color = AppColor.purpleColor;
      case TaskStatus.completedTask:
        color = AppColor.greenColor;
      case TaskStatus.cancelledTask:
        color = AppColor.redColor;
    }
    return color;
  }

  String _getStatus() {
    late String st;
    switch (status) {
      case TaskStatus.newTask:
        st = "New";
      case TaskStatus.progressTask:
        st = "Progress";
      case TaskStatus.completedTask:
        st = "Completed";
      case TaskStatus.cancelledTask:
        st = "Cancelled";
    }
    return st;
  }

  String _getDate() {
    DateTime unFormattedDate = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(unFormattedDate);
  }

  void _onTapEditStatusButton() {

  }

  Future<void> _onTapDeleteTaskButton(BuildContext context) async {
    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.deleteTaskUrl(taskId),
    );

    if (response.isSuccess) {
      refreshStatusCount!();
      refreshList();
      Utils.toastMessage("Deleted");
    } else {
      Utils.snackBar(response.message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.whiteColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(subtitle),
            Text("Date: ${_getDate()}"),
            Row(
              children: [
                Chip(
                  label: Text(
                    _getStatus(),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: _getChipColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide.none,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _onTapEditStatusButton();
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    _onTapDeleteTaskButton(context);
                  },
                  icon: Icon(Icons.delete, color: AppColor.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/data/services/network_client.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/data/utils/app_urls.dart';

enum TaskStatus { newTask, progressTask, completedTask, cancelledTask }

class TaskCard extends StatefulWidget {
  final String taskId;
  final TaskStatus status;
  final String title;
  final String subtitle;
  final String date;
  final int index;
  final VoidCallback refreshList;
  final VoidCallback? refreshStatusCount;

  const TaskCard({
    super.key,
    required this.taskId,
    required this.status,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.index,
    required this.refreshList,
    this.refreshStatusCount,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  final _statusMap = {
    TaskStatus.newTask: {'label': 'New', 'color': AppColor.blueColor},
    TaskStatus.progressTask: {'label': 'Progress', 'color': AppColor.purpleColor},
    TaskStatus.completedTask: {'label': 'Completed', 'color': AppColor.greenColor},
    TaskStatus.cancelledTask: {'label': 'Cancelled', 'color': AppColor.redColor},
  };

  String get _statusLabel => _statusMap[widget.status]!['label'] as String;
  Color get _statusColor => _statusMap[widget.status]!['color'] as Color;

  String get _formattedDate => DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.date));



  bool _isSelected(String label) => _statusLabel == label;

  Future<void> _changeTaskStatus(String status) async {
    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.updateTaskStatusURL(widget.taskId, status),
    );

    if (response.isSuccess) {
      widget.refreshStatusCount?.call();
      widget.refreshList();
    } else {
      Utils.snackBar(response.message, context);
    }
  }

  Future<void> _deleteTask() async {
    final NetworkResponse response = await NetworkClient.getRequest(
      url: AppURLs.deleteTaskUrl(widget.taskId),
    );

    if (response.isSuccess) {
      widget.refreshStatusCount?.call();
      widget.refreshList();
      Utils.toastMessage("Deleted");
    } else {
      Utils.snackBar(response.message, context);
    }
  }

  void _showStatusDialog() {
    final options = ['New', 'Progress', 'Completed', 'Cancelled'];
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Update Status", style: TextStyle(color: AppColor.blackColor)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((label) {
            return ListTile(
              title: Text(label),
              trailing: _isSelected(label) ? const Icon(Icons.done) : null,
              onTap: () {
                Navigator.pop(context);
                if (!_isSelected(label)) _changeTaskStatus(label);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Task", style: TextStyle(color: AppColor.blackColor)),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _deleteTask();
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.whiteColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(widget.subtitle),
            Text("Date: $_formattedDate"),
            Row(
              children: [
                Chip(
                  label: Text(
                    _statusLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: _statusColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _showStatusDialog,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: AppColor.primaryColor),
                  onPressed: _showDeleteDialog,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
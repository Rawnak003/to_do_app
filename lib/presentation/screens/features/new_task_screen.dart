import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/data/models/task_count_list_model.dart';
import 'package:to_do_application/data/models/task_count_model.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool _showFAB = true;

  List<String> date = [
    '01-01-2025',
    '02-01-2025',
    '03-01-2025',
    '04-01-2025',
    '05-01-2025',
    '06-01-2025',
    '07-01-2025',
    '08-01-2025',
    '09-01-2025',
    '10-01-2025',
  ];

  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
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
            _taskStatusCountShow(),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                itemCount: date.length,
                itemBuilder:
                    (context, index) => TaskCard(
                      title: "This is title",
                      subtitle: "This is subtitle",
                      date: date,
                      status: TaskStatus.newTask,
                      index: index,
                    ),
                separatorBuilder: (context, index) => const SizedBox(height: 2),
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

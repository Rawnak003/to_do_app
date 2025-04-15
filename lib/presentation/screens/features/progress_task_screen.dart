import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/presentation/widgets/task_card_widget.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: ListView.separated(
            itemCount: date.length,
            itemBuilder:
                (context, index) => TaskCard(
                  title: "This is title",
                  subtitle: "This is subtitle",
                  date: 'date',
                  status: TaskStatus.progressTask,
                  index: index,
                ),
            separatorBuilder: (context, index) => const SizedBox(height: 5),
          ),
        ),
      ),
    );
  }
}

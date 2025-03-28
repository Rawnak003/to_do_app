import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/presentation/widgets/details_show_card__widget.dart';
import 'package:to_do_application/presentation/widgets/task_card_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
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
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && _showFAB) {
        setState(() {
          _showFAB = false; // Remove FAB when scrolling
        });
      } else if (_scrollController.offset <= 0 && !_showFAB) {
        setState(() {
          _showFAB = true; // Show FAB when at the top
        });
      }
    });
  }

  void _onTapAddTask() {
    Navigator.pushNamed(
      context,
      RoutesName.addTask,
    );
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
              : null, // Completely removes FAB when scrolling

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailsShowCard(title: 'New', count: 10),
                DetailsShowCard(title: 'Progress', count: 10),
                DetailsShowCard(title: 'Completed', count: 10),
                DetailsShowCard(title: 'Cancelled', count: 10),
              ],
            ),
            const SizedBox(height: 8),

            Expanded(
              child: ListView.separated(
                controller: _scrollController, // Added controller
                itemCount: date.length,
                itemBuilder:
                    (context, index) => TaskCard(
                      title: "This is title",
                      subtitle: "This is subtitle",
                      date: date,
                      status: TaskStatus.newTask,
                      index: index,
                    ),
                separatorBuilder: (context, index) => const SizedBox(height: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

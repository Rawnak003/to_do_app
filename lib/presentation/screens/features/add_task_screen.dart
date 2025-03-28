import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/presentation/widgets/custom_app_bar.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final TextEditingController _taskTEController = TextEditingController();
  final TextEditingController _taskDescriptionTEController = TextEditingController();


  @override
  void dispose() {
    _taskTEController.dispose();
    _taskDescriptionTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: CustomAppBar(),
        body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),
                  Text(
                    AppStrings.addNewTask,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _taskTEController,
                    decoration: InputDecoration(
                      hintText: AppStrings.taskName,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    maxLines: 12,
                    controller: _taskDescriptionTEController,
                    decoration: InputDecoration(
                      hintText: AppStrings.taskDescription,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.addTask,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

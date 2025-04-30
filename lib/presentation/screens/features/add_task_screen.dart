import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/presentation/controllers/add_task_controller.dart';
import 'package:to_do_application/presentation/widgets/center_circular_indicator_widget.dart';
import 'package:to_do_application/presentation/widgets/custom_app_bar.dart';
import 'package:to_do_application/presentation/widgets/screen_background.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskTEController = TextEditingController();
  final TextEditingController _taskDescriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AutovalidateMode _autoValidateMode = AutovalidateMode.onUnfocus;
  final AddTaskController _addTaskController = Get.find<AddTaskController>();

  @override
  void dispose() {
    _taskTEController.dispose();
    _taskDescriptionTEController.dispose();
    super.dispose();
  }

  void _onTapSubmitButton() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    final bool isTaskAdded = await _addTaskController.addTask(
      _taskTEController.text.trim(),
      _taskDescriptionTEController.text.trim(),
    );
    if (isTaskAdded) {
      _allCLear();
      Get.focusScope?.unfocus();
      Get.back(result: true);
      Utils.toastMessage("New Task Added!");
    } else {
      Utils.toastMessage("Adding Failed!");
    }
  }

  void _allCLear() {
    _taskTEController.clear();
    _taskDescriptionTEController.clear();
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
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
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
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter task title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: 12,
                      controller: _taskDescriptionTEController,
                      decoration: InputDecoration(
                        hintText: AppStrings.taskDescription,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter task description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    GetBuilder<AddTaskController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.addTaskInProgress == false,
                          replacement: const CenterCircularIndicatorWidget(),
                          child: ElevatedButton(
                            onPressed: () {
                              _onTapSubmitButton();
                            },
                            child: Text(
                              AppStrings.addTask,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

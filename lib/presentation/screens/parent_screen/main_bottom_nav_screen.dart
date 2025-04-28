import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/presentation/screens/features/cancelled_task_screen.dart';
import 'package:to_do_application/presentation/screens/features/completed_task_screen.dart';
import 'package:to_do_application/presentation/screens/features/new_task_screen.dart';
import 'package:to_do_application/presentation/screens/features/progress_task_screen.dart';
import 'package:to_do_application/presentation/widgets/custom_app_bar.dart';
import 'package:to_do_application/presentation/controllers/main_bottom_nav_controller.dart'; // Import your controller

class MainBottomNavScreen extends StatelessWidget {
  MainBottomNavScreen({super.key});

  final List<Widget> _screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: CustomAppBar(),
        body: GetBuilder<MainBottomNavController>(
          builder: (controller) {
            return _screens[controller.selectedIndex];
          },
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.white,
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
                }
                return TextStyle(color: Colors.black45);
              },
            ),
          ),
          child: GetBuilder<MainBottomNavController>(
            builder: (controller) {
              return NavigationBar(
                selectedIndex: controller.selectedIndex,
                onDestinationSelected: (index) {
                  controller.changeIndex(index);
                },
                backgroundColor: AppColor.primaryColor,
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.add_task),
                    label: 'New',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.hourglass_top_outlined),
                    label: 'Progress',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.playlist_add_check_rounded),
                    label: 'Completed',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.free_cancellation_outlined),
                    label: 'Cancelled',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

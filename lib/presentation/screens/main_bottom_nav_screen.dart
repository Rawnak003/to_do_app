import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/presentation/screens/features/cancelled_task_screen.dart';
import 'package:to_do_application/presentation/screens/features/completed_task_screen.dart';
import 'package:to_do_application/presentation/screens/features/new_task_screen.dart';
import 'package:to_do_application/presentation/screens/features/progress_task_screen.dart';

import '../widgets/custom_app_bar.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {

  int _selectedIndex = 0;
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
        body: _screens[_selectedIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.white, // Optional: Remove selection indicator
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // White when selected
                }
                return TextStyle(color: Colors.black45); // Default color when not selected
              },
            ),
          ),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
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
          ),
        ),
      ),
    );
  }
}


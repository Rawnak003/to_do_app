import 'package:flutter/material.dart';
import 'package:to_do_application/presentation/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      home: SplashScreen(),
    );
  }
}

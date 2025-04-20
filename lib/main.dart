import 'package:flutter/material.dart';
import 'package:to_do_application/app.dart';
import 'package:to_do_application/presentation/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthController.getUserInformation();
  runApp(TaskManagerApp());
}
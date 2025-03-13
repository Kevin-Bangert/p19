import 'package:flutter/material.dart';
import 'task_list_screen.dart';
import 'mock_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskListScreen(
        repo: MockDatabase(),
      ),
    );
  }
}

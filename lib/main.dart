import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/presentation/Home/UI/home_view.dart';
import 'package:tasks/presentation/Home/logic/task_provider.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => TaskListViewModel(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tasks/presentation/Home/UI/add_task_screen.dart';
import 'package:tasks/presentation/Home/UI/widgets/home_view_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: const HomeViewBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTaskScreen(),
              ));
        },
        backgroundColor: const Color(0xFF6A3DE8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

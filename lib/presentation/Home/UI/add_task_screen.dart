import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/presentation/Home/UI/widgets/animated_container.dart';
import 'package:tasks/presentation/Home/UI/widgets/select_time_widget.dart';
import 'package:tasks/presentation/Home/data/models/tasks.dart';
import 'package:tasks/presentation/Home/logic/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  TaskPriority _priority = TaskPriority.medium;
  bool _isExpanded = false;

  @override
  void dispose() {
    _titleController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        time: _timeController.text,
        priority: _priority,
      );
      Provider.of<TaskListViewModel>(context, listen: false).addTask(task);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'What needs to be done?',
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),

              speed: const Duration(milliseconds: 100), // Speed of typing
            ),
          ],
          totalRepeatCount: 1, // Number of times the animation repeats
          pause: const Duration(milliseconds: 1000), // Pause after each text
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF121212), Color(0xFF202020)],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header Section with Animation
              ContainerWithAnimation(
                onTap: () {
                  setState(() {
                    _isExpanded = true;
                  });
                },
                onFieldSubmitted: (_) {
                  setState(() {
                    _isExpanded = false;
                  });
                  FocusScope.of(context).unfocus();
                },
                isExpanded: _isExpanded,
                titleController: _titleController,
              ),

              // Main Content
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      // Time Selection Card
                      SelectTimeWidget(timeController: _timeController),

                      const SizedBox(height: 24),

                      // Priority Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12, bottom: 16),
                            child: Text(
                              'Priority Level',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              children: TaskPriority.values.map((priority) {
                                final isSelected = _priority == priority;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _priority = priority;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? priority.color
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: priority.color,
                                        width: 2,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: priority.color
                                                    .withOpacity(0.4),
                                                blurRadius: 8,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 4),
                                              )
                                            ]
                                          : null,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          _getPriorityIcon(priority),
                                          color: isSelected
                                              ? Colors.white
                                              : priority.color,
                                          size: 28,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          priority.name,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : priority.color,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Save Button
                      ElevatedButton(
                        onPressed: _saveTask,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6A3DE8),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          shadowColor: const Color(0xFF6A3DE8).withOpacity(0.4),
                        ),
                        child: const Text(
                          'SAVE TASK',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getPriorityIcon(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Icons.arrow_downward_rounded;
      case TaskPriority.medium:
        return Icons.remove_rounded;
      case TaskPriority.high:
        return Icons.arrow_upward_rounded;
      default:
        return Icons.remove_rounded;
    }
  }
}

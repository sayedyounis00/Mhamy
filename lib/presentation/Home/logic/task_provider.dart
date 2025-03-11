import 'package:flutter/material.dart';
import 'package:tasks/presentation/Home/data/models/tasks.dart';

enum TaskFilter { all, today, important, completed }

class TaskListViewModel extends ChangeNotifier {
  final searchController = TextEditingController();

  List<Task> _tasks = [];
  List<Task> searchedTasks = [];
  TaskFilter _currentFilter = TaskFilter.all;

  TaskListViewModel() {
    _initializeTasks();
  }

  void _initializeTasks() {
    _tasks = [
      Task(
        id: '1',
        title: "Finalize project proposal",
        time: "10:00 AM",
        isCompleted: true,
        priority: TaskPriority.high,
      ),
      Task(
        id: '2',
        title: "Meeting with design team",
        time: "11:30 AM",
        isCompleted: true,
        priority: TaskPriority.medium,
      ),
      Task(
        id: '3',
        title: "Research new API integration",
        time: "2:00 PM",
        isCompleted: false,
        priority: TaskPriority.medium,
      ),
      Task(
        id: '4',
        title: "Prepare presentation slides",
        time: "4:30 PM",
        isCompleted: false,
        priority: TaskPriority.high,
      ),
      Task(
        id: '5',
        title: "Review code pull requests",
        time: "5:15 PM",
        isCompleted: false,
        priority: TaskPriority.low,
      ),
    ];
  }

//? a get function to make login for filter the home content
  List<Task> get tasks {
    switch (_currentFilter) {
      case TaskFilter.all:
        return _tasks;
      case TaskFilter.today:
        return _tasks.where((task) => task.time.isNotEmpty).toList();
      case TaskFilter.important:
        return _tasks
            .where((task) => task.priority == TaskPriority.high)
            .toList();
      case TaskFilter.completed:
        return _tasks.where((task) => task.isCompleted).toList();
    }
  }

  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((task) => task.isCompleted).length;
  double get progressValue => completedTasks / totalTasks;
  String get progressText => "$completedTasks/$totalTasks Tasks";
  TaskFilter get currentFilter => _currentFilter;

  void setFilter(TaskFilter filter) {
    _currentFilter = filter;
    notifyListeners();
  }
//**
//The method takes a taskId parameter to identify which task to update.
// It first finds the index of the task with the matching id using the indexWhere method, which searches through the _tasks list.
// The if (taskIndex != -1) check ensures the task was actually found (if not found, indexWhere returns -1).
// When the task is found, it creates a new task object by:

// Using the copyWith method (likely from a data class or immutable model pattern)
// Inverting the current isCompleted status with the ! operator

// It replaces the old task with the updated one at the same position in the list.
// Finally, it calls notifyListeners() to notify any listeners (like UI components) that the data has changed.
// */
  void toggleTaskStatus(String taskId) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex] = _tasks[taskIndex].copyWith(
        isCompleted: !_tasks[taskIndex].isCompleted,
      );
      notifyListeners();
    }
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void searchForTask(String searcherChar) {
    searchedTasks = tasks
        .where((task) => task.title.toLowerCase().contains(searcherChar))
        .toList();
    notifyListeners();
  }
}

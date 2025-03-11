import 'package:flutter/material.dart';

enum TaskPriority { low, medium, high }

extension TaskPriorityExtension on TaskPriority {
  Color get color {
    switch (this) {
      case TaskPriority.low:
        return const Color(0xFF4CAF50);
      case TaskPriority.medium:
        return const Color(0xFFFFA726);
      case TaskPriority.high:
        return const Color(0xFFF44336);
    }
  }
  
  String get name {
    return toString().split('.').last[0].toUpperCase() + 
           toString().split('.').last.substring(1).toLowerCase();
  }
}

class Task {
  final String id;
  final String title;
  final String time;
  bool isCompleted;
  final TaskPriority priority;

  Task({
    required this.id,
    required this.title,
    required this.time,
    this.isCompleted = false,
    required this.priority,
  });

  Task copyWith({
    String? id,
    String? title,
    String? time,
    bool? isCompleted,
    TaskPriority? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
    );
  }
}
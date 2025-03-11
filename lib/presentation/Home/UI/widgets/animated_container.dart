import 'package:flutter/material.dart';

class ContainerWithAnimation extends StatelessWidget {
  const ContainerWithAnimation({
    super.key,
    required bool isExpanded,
    required TextEditingController titleController,
    required this.onFieldSubmitted,
    required this.onTap,
  })  : _isExpanded = isExpanded,
        _titleController = titleController;

  final bool _isExpanded;
  final TextEditingController _titleController;
  final Function(String) onFieldSubmitted;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: _isExpanded ? 150 : 200,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: TextFormField(
          controller: _titleController,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(
            hintText: "Task Title",
            hintStyle: TextStyle(
              color: Colors.white54,
              fontSize: 28,
              fontWeight: FontWeight.w300,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Task title cannot be empty';
            }
            return null;
          },
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }
}

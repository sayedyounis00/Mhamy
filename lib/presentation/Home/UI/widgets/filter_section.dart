import 'package:flutter/material.dart';
import 'package:tasks/presentation/Home/UI/widgets/task_chip.dart';
import 'package:tasks/presentation/Home/logic/task_provider.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({
    super.key,
    required this.viewModel,
  });

  final TaskListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        children: [
          FilterChipWidget(
            label: 'All Tasks',
            isSelected: viewModel.currentFilter == TaskFilter.all,
            onTap: () => viewModel.setFilter(TaskFilter.all),
          ),
          FilterChipWidget(
            label: 'Today',
            isSelected: viewModel.currentFilter == TaskFilter.today,
            onTap: () => viewModel.setFilter(TaskFilter.today),
          ),
          FilterChipWidget(
            label: 'Important',
            isSelected: viewModel.currentFilter == TaskFilter.important,
            onTap: () => viewModel.setFilter(TaskFilter.important),
          ),
          FilterChipWidget(
            label: 'Completed',
            isSelected: viewModel.currentFilter == TaskFilter.completed,
            onTap: () => viewModel.setFilter(TaskFilter.completed),
          ),
        ],
      ),
    );
  }
}

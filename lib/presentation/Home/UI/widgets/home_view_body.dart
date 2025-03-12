import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/presentation/Home/UI/widgets/custum_app_bar.dart';
import 'package:tasks/presentation/Home/UI/widgets/filter_section.dart';
import 'package:tasks/presentation/Home/UI/widgets/painter.dart';
import 'package:tasks/presentation/Home/UI/widgets/progress_bar_setion.dart';
import 'package:tasks/presentation/Home/UI/widgets/search_title_bar.dart';
import 'package:tasks/presentation/Home/logic/task_provider.dart';
import 'package:tasks/presentation/Home/UI/widgets/task_item.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskListViewModel>(context);
    final alltasks = viewModel.tasks;
    final searchedTasks = viewModel.searchedTasks;

    return Stack(
      children: [
        // Background gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF6A3DE8), Color(0xFF4A148C)],
            ),
          ),
        ),
        // Background pattern
        Positioned.fill(
          child: Opacity(
            opacity: 0.05,
            child: CustomPaint(
              painter: PatternPainter(),
            ),
          ),
        ),

        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const CustumAppBar(),

              // Progress section
              ProgressBarSection(viewModel: viewModel),

              const SizedBox(height: 20),

              // Filter chips
              FilterSection(viewModel: viewModel),

              const SizedBox(height: 10),

              //? Tasks List
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SearchAndTitleBar(
                        searchController: viewModel.searchController,
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: viewModel.searchController.text.isEmpty
                              ? alltasks.length
                              : searchedTasks.length,
                          itemBuilder: (context, index) {
                            final task = viewModel.searchController.text.isEmpty
                                ? alltasks[index]
                                : searchedTasks[index];
                            return TaskItemWidget(
                              task: task,
                              onToggle: () =>
                                  viewModel.toggleTaskStatus(task.id),
                              onDelete: () => viewModel.deleteTask(task.id),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

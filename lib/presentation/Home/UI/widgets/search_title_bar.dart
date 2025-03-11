import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasks/presentation/Home/logic/task_provider.dart';

class SearchAndTitleBar extends StatelessWidget {
  const SearchAndTitleBar({
    super.key,
    required this.viewModel,
  });

  final TaskListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Tasks (${viewModel.tasks.length})',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, size: 28),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

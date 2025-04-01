import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tasks/presentation/Home/UI/widgets/animated_search_icns.dart';
import 'package:tasks/presentation/Home/logic/task_provider.dart';

class SearchAndTitleBar extends StatefulWidget {
  const SearchAndTitleBar({
    super.key,
    required this.searchController,
  });
  final TextEditingController searchController;

  @override
  State<SearchAndTitleBar> createState() => _SearchAndTitleBarState();
}

class _SearchAndTitleBarState extends State<SearchAndTitleBar> {
  final FocusNode _focusNode = FocusNode();

  bool _isSearching = false;

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskListViewModel>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _isSearching
              ? SizedBox(
                  height: 20,
                  width: MediaQuery.of(context).size.width * .7,
                  child: TextField(
                    controller: viewModel.searchController,
                    focusNode: _focusNode,
                    onSubmitted: (value) {
                      setState(() {
                        _isSearching = !_isSearching;
                        viewModel.searchController.clear();
                      });
                      Focus.of(context).unfocus();
                    },
                    onChanged: (searchChar) {
                      viewModel.searchForTask(searchChar);
                    },
                    showCursor: false,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 15),
                      border: UnderlineInputBorder(),
                    ),
                  ))
              : Text(
                  'My Tasks (${viewModel.tasks.length})',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: AnimatedSearchIcon(
                isSearching: _isSearching,
                onTap: _toggleSearch,
              )),
        ],
      ),
    );
  }
}

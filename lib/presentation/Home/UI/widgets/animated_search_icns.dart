import 'package:flutter/material.dart';

class AnimatedSearchIcon extends StatefulWidget {
  final bool isSearching;
  final Function() onTap;

  const AnimatedSearchIcon({
    super.key,
    required this.isSearching,
    required this.onTap,
  });

  @override
  State<AnimatedSearchIcon> createState() => _AnimatedSearchIconState();
}

class _AnimatedSearchIconState extends State<AnimatedSearchIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isSearching) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedSearchIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSearching != oldWidget.isSearching) {
      if (widget.isSearching) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Search icon that fades out and rotates when searching
              Opacity(
                opacity: 1 - _animation.value,
                child: Transform.rotate(
                  angle: _animation.value * 3.14 / 4,
                  child: const Icon(Icons.search),
                ),
              ),
              // Close icon that fades in and rotates when searching
              Opacity(
                opacity: _animation.value,
                child: Transform.rotate(
                  angle: (1 - _animation.value) * 3.14 / 4,
                  child: const Icon(Icons.close),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

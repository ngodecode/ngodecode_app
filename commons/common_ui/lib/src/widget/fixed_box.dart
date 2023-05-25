import 'package:flutter/material.dart';

class FixedBox extends StatelessWidget {
  const FixedBox({
    Key? key,
    required this.child,
    required this.width,
    this.scrollable,
  }) : super(key: key);

  final Widget child;
  final double width;
  final bool? scrollable;

  @override
  Widget build(BuildContext context) {
    final scrollController = scrollable == true ? ScrollController() : null;
    return Center(
      child: SizedBox(
        width: width,
        child: Scrollbar(
          controller: scrollController,
          scrollbarOrientation: ScrollbarOrientation.bottom,
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: width,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

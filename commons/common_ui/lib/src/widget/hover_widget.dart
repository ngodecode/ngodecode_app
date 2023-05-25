import 'package:flutter/material.dart';

class HoverWidget extends StatefulWidget {
  const HoverWidget({required this.builder, Key? key}) : super(key: key);

  final Widget Function(bool isHovered) builder;

  @override
  State<HoverWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _onHoverChanged(enabled: true),
      onExit: (event) => _onHoverChanged(enabled: false),
      child: widget.builder(_isHovered),
    );
  }

  void _onHoverChanged({required bool enabled}) {
    setState(() {
      _isHovered = enabled;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:postj/src/widgets/hide_on_scroll_controller.dart';

class HideOnScrollOverlay extends StatefulWidget {
  const HideOnScrollOverlay({
    super.key,
    required this.controller,
    required this.child,
    this.height = 60,
  });
  final HideOnScrollController controller;
  final Widget child;
  final double height;

  @override
  State<HideOnScrollOverlay> createState() => _HideOnScrollOverlayState();
}

class _HideOnScrollOverlayState extends State<HideOnScrollOverlay> {
  @override
  void initState() { super.initState(); widget.controller.addListener(_onChanged); }
  @override
  void didUpdateWidget(covariant HideOnScrollOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onChanged);
      widget.controller.addListener(_onChanged);
    }
  }
  void _onChanged() { if (mounted) setState(() {}); }
  @override
  void dispose() { widget.controller.removeListener(_onChanged); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bar = SizedBox(height: widget.height, child: widget.child);
    return AnimatedSlide(
      offset: widget.controller.visible ? Offset.zero : const Offset(0, -1),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: widget.controller.visible ? 1 : 0,
        duration: const Duration(milliseconds: 140),
        child: SafeArea(bottom: false, child: bar),
      ),
    );
  }
}

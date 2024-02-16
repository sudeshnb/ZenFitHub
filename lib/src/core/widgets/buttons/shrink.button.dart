import 'package:flutter/material.dart';

class ShrinkButtonWithChild extends StatefulWidget {
  final Function onPressed;
  final double shrinkScale;

  final Widget child;
  const ShrinkButtonWithChild({
    super.key,
    required this.onPressed,
    required this.child,
    this.shrinkScale = 0.9,
  });

  @override
  State<ShrinkButtonWithChild> createState() => _ShrinkButtonWithChildState();
}

class _ShrinkButtonWithChildState extends State<ShrinkButtonWithChild>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scale;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    //
    scale = Tween<double>(
      begin: 1.0,
      end: widget.shrinkScale,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    super.initState();
  }

  Future<void> _onTap() async {
    _controller.forward();
    await Future.delayed(
        const Duration(milliseconds: 200), () => _controller.reverse());
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ScaleTransition(
        scale: scale,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

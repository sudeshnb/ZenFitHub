import 'package:flutter/material.dart';

class OpacityTranslateAnimation extends StatelessWidget {
  const OpacityTranslateAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
  });

  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: duration,
      curve: Curves.fastOutSlowIn,
      builder: (context, double value, _) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
    );
  }
}

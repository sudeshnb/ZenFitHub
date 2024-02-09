import 'package:flutter/material.dart';

import 'model/enum.dart';

class AppPageTransition {
  final Widget child;

  /// Duration for your transition default is 300 ms
  final Duration duration;

  /// Duration for your pop transition default is 300 ms
  final Duration reverseDuration;

  final PageTransitionType type;

  /// Alignment for transitions
  final Alignment? alignment;

  /// Curves for transitions
  final Curve curve;

  AppPageTransition({
    required this.child,
    this.curve = Curves.linear,
    this.alignment = Alignment.topCenter,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.type = PageTransitionType.fade,
  });

  Route get build {
    return PageRouteBuilder(
      transitionDuration: duration,
      reverseTransitionDuration: reverseDuration,
      pageBuilder: (context, animation, secondaryAnimation) {
        switch (type) {
          case PageTransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
            // ignore: dead_code
            break;

          /// PageTransitionType.rightToLeft which is the give us right to left transition
          case PageTransitionType.rightToLeft:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
            // ignore: dead_code
            break;

          /// PageTransitionType.leftToRight which is the give us left to right transition
          case PageTransitionType.leftToRight:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
            // ignore: dead_code
            break;

          /// PageTransitionType.topToBottom which is the give us up to down transition
          case PageTransitionType.topToBottom:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
            // ignore: dead_code
            break;

          /// PageTransitionType.downToUp which is the give us down to up transition
          case PageTransitionType.bottomToTop:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
            // ignore: dead_code
            break;

          /// PageTransitionType.scale which is the scale functionality for transition you can also use curve for this transition

          case PageTransitionType.scale:
            return ScaleTransition(
              alignment: alignment!,
              scale: CurvedAnimation(
                parent: animation,
                curve: Interval(
                  0.00,
                  0.50,
                  curve: curve,
                ),
              ),
              child: child,
            );
            // ignore: dead_code
            break;

          /// PageTransitionType.size which is the rotate functionality for transition you can also use curve for this transition

          case PageTransitionType.size:
            return Align(
              alignment: alignment!,
              child: SizeTransition(
                sizeFactor: CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
                child: child,
              ),
            );
            // ignore: dead_code
            break;
          case PageTransitionType.rightToLeftWithFade:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
            );
            // ignore: dead_code
            break;

          /// PageTransitionType.leftToRightWithFade which is the fade functionality from left o right with curve

          case PageTransitionType.leftToRightWithFade:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
              ),
              child: FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
            );
            // ignore: dead_code
            break;

          /// FadeTransitions which is the fade transition

          default:
            return FadeTransition(opacity: animation, child: child);
        }
      },
    );
  }
}

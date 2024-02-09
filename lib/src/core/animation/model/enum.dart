/// Transition enum
enum PageTransitionType {
  /// Fade Animation
  fade,

  /// Right to left animation
  rightToLeft,

  /// Left to right animation
  leftToRight,

  /// Top to bottom animation

  topToBottom,

  /// Bottom to top animation

  bottomToTop,

  /// Scale animation

  scale,

  /// Rotate animation

  rotate,

  /// Size animation

  size,

  /// Right to left with fading animation

  rightToLeftWithFade,

  /// Left to right with fading animation

  leftToRightWithFade,

  /// Left to right slide as if joined

  /// Pop the current screen left to right

  leftToRightPop,

  /// Pop the current screen right to left

  rightToLeftPop,

  /// Pop the current screen top to bottom

  topToBottomPop,

  /// Pop the current screen bottom to top

  bottomToTopPop,
}

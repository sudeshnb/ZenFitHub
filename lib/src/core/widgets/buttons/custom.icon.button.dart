import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';

import 'shrink.button.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.dimension,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(key: key);

  final Alignment? alignment;

  final double? height;

  final double? dimension;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => ShrinkButtonWithChild(
        onPressed: onTap ?? () {},
        child: SizedBox.square(
          // height: height ?? 0,
          // width: width ?? 0,
          dimension: dimension,
          child: Container(
            // height: height ?? 0,
            // width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: AppColor.blueGray50.withOpacity(1),
                  borderRadius: BorderRadius.circular(5.h),
                ),
            child: Center(child: child),
          ),
        ),
      );
}

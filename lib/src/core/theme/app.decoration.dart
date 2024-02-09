import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';

class AppDecoration {
  static BoxDecoration get outlineGray => BoxDecoration(
        color: AppColor.gray100,
        border: Border.all(
          color: AppColor.gray700.withOpacity(0.25),
          width: 1.w,
          strokeAlign: strokeAlignCenter,
        ),
      );

  static BoxDecoration get fillGray7001 => BoxDecoration(
        color: AppColor.gray700.withOpacity(0.25),
      );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(10.w);
}

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

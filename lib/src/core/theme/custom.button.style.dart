import 'package:flutter/material.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static BoxDecoration get fillGreen => BoxDecoration(
        color: AppColor.green,
        borderRadius: BorderRadius.circular(10.0),
      );
  static BoxDecoration get outline => BoxDecoration(
        color: AppColor.gray100,
        border: Border.all(color: AppColor.gray400),
        borderRadius: BorderRadius.circular(10.0),
      );

  static BoxDecoration get fillIndigo => BoxDecoration(
        color: AppColor.indigo500,
        borderRadius: BorderRadius.circular(10.0),
      );

  static BoxDecoration get fillAmber => BoxDecoration(
        color: AppColor.amber500,
        borderRadius: BorderRadius.circular(10.0),
      );

  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: AppColor.gray100,
        border: Border.all(color: AppColor.gray400),
        borderRadius: BorderRadius.circular(10.0),
      );

  // static BoxDecoration get fillEmpty => const BoxDecoration();

  static BoxDecoration get fillRed => BoxDecoration(
        color: AppColor.red,
        borderRadius: BorderRadius.circular(10.0),
      );
}

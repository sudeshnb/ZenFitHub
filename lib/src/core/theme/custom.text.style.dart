import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/constants/colors.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static TextStyle get bodyLarge => TextStyle(
        color: AppColor.black,
        fontFamily: 'DM Sans',
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get bodyLargeBebas => bodyLarge.copyWith(
        fontFamily: 'Bebas',
      );
  static TextStyle get bodyLargeBebasW => bodyLargeBebas.copyWith(
        color: AppColor.white,
      );
  static TextStyle get displayMedium => TextStyle(
        color: AppColor.black,
        fontFamily: 'Bebas Neue',
        fontSize: 48.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get headlineLarge => TextStyle(
        color: AppColor.black,
        fontSize: 30.sp,
        fontFamily: 'Bebas',
        fontWeight: FontWeight.w400,
      );
  static TextStyle get titleLarge => TextStyle(
        color: AppColor.white,
        fontSize: 16.sp,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleLargeB =>
      titleLarge.copyWith(color: AppColor.black);

  static TextStyle get titleSmallDMSansBluegray => TextStyle(
        color: AppColor.blueGray900,
        fontSize: 15.sp,
        fontFamily: 'DM Sans',
      );
  static TextStyle get titleLargeBebas => TextStyle(
        color: AppColor.white,
        fontSize: 20.sp,
        fontFamily: 'Bebas',
        fontWeight: FontWeight.w400,
      );

  static TextStyle get titleSmall => TextStyle(
        color: AppColor.black.withOpacity(0.6),
        fontSize: 14.sp,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      );
  static TextStyle get titleSmallBold => TextStyle(
        color: AppColor.black.withOpacity(0.6),
        fontSize: 14.sp,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
      );
  static TextStyle get labelLarge => TextStyle(
        color: AppColor.black.withOpacity(0.6),
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        fontFamily: 'Montserrat',
      );

  static TextStyle get titleBold => TextStyle(
        color: AppColor.black.withOpacity(0.6),
        fontSize: 18.sp,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
      );

  static TextStyle get titleLargeDMSans => TextStyle(
        fontFamily: 'DM Sans',
        color: AppColor.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get labelMedium => TextStyle(
        color: AppColor.white,
        fontSize: 10.sp,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      );

  static TextStyle get bodyMediumPoppins => TextStyle(
        color: AppColor.black,
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get labelLargeDMSans => TextStyle(
        fontFamily: 'DM Sans',
        color: AppColor.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';

// ignore: must_be_immutable
class RecipecardItemWidget extends StatelessWidget {
  RecipecardItemWidget(this.model, {Key? key}) : super(key: key);

  MealModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 150.w,
          width: 318.h,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              CustomImageView(
                imagePath: model.image,
                height: 150.w,
                width: 318.h,
                radius: BorderRadius.circular(10.h),
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 14.w, right: 12.h),
              //   child: CustomIconButton(
              //     height: 24.w,
              //     width: 24.w,
              //     padding: EdgeInsets.all(6.h),
              //     alignment: Alignment.topRight,
              //     child: CustomImageView(
              //       imagePath: model.favoriteIcon,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(height: 12.w),
        Text(
          model.name,
          style: CustomTextStyles.labelLarge.copyWith(fontWeight: Font.b),
        ),
        SizedBox(height: 6.w),
        Row(
          children: [
            CustomImageView(
                imagePath: AppIcons.fireImage, height: 10.w, width: 8.h),
            Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                '${model.kcal} kcal',
                style: CustomTextStyles.labelLarge.copyWith(fontSize: 12.sp),
              ),
            ),
            Container(
              height: 8.w,
              width: 1.h,
              margin: EdgeInsets.only(left: 11.h, top: 2.w, bottom: 2.w),
              decoration: BoxDecoration(
                color: AppColor.gray600,
              ),
            ),
            CustomImageView(
              imagePath: AppIcons.clockImage,
              height: 11.w,
              width: 11.w,
              margin: EdgeInsets.only(left: 9.h),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.h),
              child: Text(
                '${model.min} min',
                style: CustomTextStyles.labelLarge.copyWith(fontSize: 12.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 21.w),
      ],
    );
  }
}

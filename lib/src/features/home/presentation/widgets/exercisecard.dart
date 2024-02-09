// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';

class ExercisecardItemWidget extends StatelessWidget {
  const ExercisecardItemWidget(this.model, {Key? key}) : super(key: key);

  final ExerciseModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 91.w,
            width: 91.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 90.w,
                    width: 90.w,
                    decoration: BoxDecoration(
                      color: AppColor.amber500,
                      borderRadius: BorderRadius.circular(10.h),
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: model.image,
                  height: 91.w,
                  width: 91.w,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.h, bottom: 11.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 146.h,
                  margin: EdgeInsets.only(left: 1.h),
                  child: Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.labelLarge
                        .copyWith(fontWeight: Font.b),
                  ),
                ),
                SizedBox(height: 10.w),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: AppIcons.fireImage,
                        height: 10.w,
                        width: 8.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6.h),
                        child: Text(
                          '${model.kcal} kcal',
                          style: CustomTextStyles.labelLarge
                              .copyWith(fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        height: 8.w,
                        width: 1.h,
                        margin:
                            EdgeInsets.only(left: 12.h, top: 2.w, bottom: 2.w),
                        decoration: BoxDecoration(color: AppColor.gray600),
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
                          style: CustomTextStyles.labelLarge
                              .copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.w),
                Text(
                  model.level,
                  style: CustomTextStyles.labelLarge.copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

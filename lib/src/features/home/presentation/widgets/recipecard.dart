import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/quickalert.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/routes/routes.dart';
import 'package:zen_fit_hub/src/core/services/services.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';
import 'package:zen_fit_hub/src/features/home/domain/usecases/usecases.dart';

class RecipecardItemWidget extends StatelessWidget {
  const RecipecardItemWidget(this.model, {Key? key}) : super(key: key);
  final MealModel model;
  Future<void> delete(BuildContext context) async {
    final response = await HomeUseCase().deleteMeals(model.id);
    response.fold(
      (l) => NavigatorService.goBack(),
      (r) => QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Sorry, something went wrong...',
        showConfirmBtn: false,
        autoCloseDuration: const Duration(seconds: 2),
        text: r,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShrinkButtonWithChild(
      onPressed: () => NavigatorService.push(
        RoutesName.mealPlan,
        arguments: model.id,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.w),
        child: Material(
          color: AppColor.red,
          child: Dismissible(
            background: Container(
              color: AppColor.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20.w),
              child: Icon(
                Icons.delete_outline_outlined,
                color: AppColor.white,
                size: 40.sp,
              ),
            ),
            direction: DismissDirection.endToStart,
            key: ValueKey<String>(model.id),
            confirmDismiss: (DismissDirection direction) async {
              await QuickAlert.show(
                context: context,
                type: QuickAlertType.confirm,
                title: 'Are you sure to delete?',
                text: 'Are you sure you want to delete this item?',
                onConfirmBtnTap: () => delete(context),
              );
              return null;
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(20.w),
                border: Border.all(width: 0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.image.isNotEmpty)
                    CustomImageView(
                      imagePath: model.image,
                      height: 150.w,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 10.w),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name,
                          maxLines: 2,
                          style: CustomTextStyles.labelLarge
                              .copyWith(fontWeight: Font.b),
                        ),
                        SizedBox(height: 6.w),
                        Row(
                          children: [
                            CustomImageView(
                                imagePath: AppIcons.fireImage,
                                height: 10.w,
                                width: 8.h),
                            Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Text(
                                '${model.kcal} kcal',
                                style: CustomTextStyles.labelLarge
                                    .copyWith(fontSize: 12.sp),
                              ),
                            ),
                            Container(
                              height: 8.w,
                              width: 1.w,
                              margin: EdgeInsets.only(
                                  left: 11.w, top: 2.w, bottom: 2.w),
                              decoration:
                                  BoxDecoration(color: AppColor.gray600),
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
                      ],
                    ),
                  ),
                  SizedBox(height: 10.w),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/animation/animation.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/constants/database.dart';
import 'package:zen_fit_hub/src/core/localization/app_localization.dart';
import 'package:zen_fit_hub/src/core/routes/routes.dart';
import 'package:zen_fit_hub/src/core/services/services.dart';
import 'package:zen_fit_hub/src/core/theme/app.decoration.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';

class FetchingMeal extends StatelessWidget {
  const FetchingMeal({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: AppDB.meals.doc(id).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Center(child: Text("Document does not exist"));
          }

          if (snapshot.connectionState == ConnectionState.active) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return MealPlanDetailsScreen(model: MealModel.fromMap(data));
          }

          return DefualtLoading.dots;
        },
      ),
    );
  }
}

class MealPlanDetailsScreen extends StatelessWidget {
  const MealPlanDetailsScreen({super.key, required this.model});
  final MealModel model;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height / 1.7;
    return Stack(
      children: [
        if (model.image.isNotEmpty)
          CustomImageView(
            imagePath: model.image,
            height: 360.w,
            width: double.infinity,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          )
        else
          Container(
            color: AppColor.gray100,
            child: CustomImageView(
              imagePath: AppImage.imgMeal,
              width: 100.w,
              alignment: const Alignment(0, -0.5),
            ),
          ),
        _buildAppBar(),
        _buildKcalMinBoxRow(height),
      ],
    );
  }

  /// Section Widget
  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconButton(
                dimension: 40.w,
                child: const Icon(Icons.arrow_back_ios_new),
                onTap: () => NavigatorService.goBack(),
              ),
              CustomIconButton(
                dimension: 40.w,
                onTap: () => NavigatorService.push(
                  RoutesName.mealPlanUpdate,
                  arguments: model,
                ),
                child: const Icon(Icons.edit),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildKcalMinBoxRow(double height) {
    return Align(
      // alignment: const Alignment(0, -0.1),
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.w),
        decoration: AppDecoration.fillOnPrimaryContainer,
        height: height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: AppIcons.fireImage,
                  height: 22.w,
                  width: 17.h,
                  color: AppColor.black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 30.w),
                  child: Text("${model.kcal} kcal",
                      style: CustomTextStyles.labelLarge),
                ),
                // const Spacer(),
                SizedBox(
                  height: 22.w,
                  child: VerticalDivider(
                      width: 1.h,
                      thickness: 1.w,
                      color: AppColor.gray600,
                      indent: 3.h,
                      endIndent: 3.h),
                ),
                CustomImageView(
                  imagePath: AppIcons.clockImage,
                  color: AppColor.black,
                  height: 22.w,
                  width: 22.w,
                  margin: EdgeInsets.only(left: 30.w, right: 10.w),
                ),
                Text("${model.min} min", style: CustomTextStyles.labelLarge),
              ],
            ),
            SizedBox(height: 40.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Text("lbl_fat".tr, style: CustomTextStyles.labelLarge),
                  SizedBox(height: 10.w),
                  Text(model.fat, style: CustomTextStyles.titleSmallBold)
                ]),
                Column(children: [
                  Text("lbl_protein".tr, style: CustomTextStyles.labelLarge),
                  SizedBox(height: 10.w),
                  Text(model.protein, style: CustomTextStyles.titleSmallBold)
                ]),
                Column(children: [
                  Text("lbl_carbs".tr, style: CustomTextStyles.labelLarge),
                  SizedBox(height: 10.w),
                  Text(model.carbs, style: CustomTextStyles.titleSmallBold)
                ])
              ],
            ),
            SizedBox(height: 40.w),
            Text(
              model.name,
              style: CustomTextStyles.titleBold,
            ),
            SizedBox(height: 10.w),
            Text(
              model.discription,
              style: CustomTextStyles.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}

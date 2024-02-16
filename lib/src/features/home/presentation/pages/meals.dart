import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/animation/animation.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/constants/database.dart';
import 'package:zen_fit_hub/src/core/localization/app_localization.dart';
import 'package:zen_fit_hub/src/core/network/connection.lost.dart';
import 'package:zen_fit_hub/src/core/routes/routes.dart';
import 'package:zen_fit_hub/src/core/services/services.dart';
import 'package:zen_fit_hub/src/core/theme/custom.button.style.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/utils/list.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';
import '../widgets/recipecard.dart';

class MealplanPage extends StatelessWidget {
  const MealplanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 20.w),
          Expanded(
            child: OfflineBuilder(
              connectivityBuilder: (context, connectivity, child) {
                final bool connected = connectivity != ConnectivityResult.none;
                if (connected) {
                  return const _MealplanList();
                }
                return const ConnectionLostScreen();
              },
              child: const SizedBox(),
            ),
          ),
          SizedBox(height: 20.w),
          CustomElevatedButton(
            text: "lbl_add_meal".tr,
            onPressed: () => NavigatorService.push(RoutesName.mealPlanAdd),
            margin: REdgeInsets.symmetric(horizontal: 20.w),
            decoration: CustomButtonStyles.fillGreen,
          ),
          SizedBox(height: 20.w),
        ],
      ),
    );
  }
}

class _EmptyMeals extends StatelessWidget {
  const _EmptyMeals();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: 0.5,
            child: CustomImageView(
              imagePath: AppImage.imgMeal,
              height: 100.w,
              width: 100.w,
            ),
          ),
          SizedBox(height: 20.w),
          SizedBox(
            width: 180.h,
            child: Text(
              "msg_favorite_recipes".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class _MealplanList extends StatelessWidget {
  const _MealplanList();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: AppDB.meals.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return DefualtLoading.dots;
        }
        if (snapshot.data != null && snapshot.data!.docs.isEmpty) {
          return const _EmptyMeals();
        }
        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(20.w),
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return RecipecardItemWidget(MealModel.fromMap(data));
              })
              .toList()
              .verticalGap(20.w),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/localization/app_localization.dart';
import 'package:zen_fit_hub/src/core/theme/custom.button.style.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';
import 'package:zen_fit_hub/src/features/auth/presentation/cubit/user.cubit.dart';
import 'package:zen_fit_hub/src/features/home/presentation/cubit/home_cubit.dart';
import '../widgets/custom.search.view.dart';
import '../widgets/category.item.card.dart';
import '../widgets/exercisecard.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Column(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: AppIcons.menu,
                      color: AppColor.black,
                    ),
                    SizedBox(width: 20.w),
                    CustomImageView(
                      imagePath:
                          (state.user != null && state.user!.image != null)
                              ? state.user!.image
                              : AppIcons.user,
                      width: 50.w,
                      height: 50.w,
                      fit: BoxFit.cover,
                      radius: BorderRadius.all(Radius.circular(50.w)),
                    ),
                    const Spacer(),
                    CustomImageView(
                      imagePath: AppIcons.notification,
                      color: AppColor.black,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 10.w),
                    const _BuildHeader(),
                    SizedBox(height: 20.w),
                    const _BuildStartExercise(),
                    SizedBox(height: 20.w),
                    const _BuildCategory(),
                    SizedBox(height: 20.w),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "lbl_popular_exercise".tr,
                              style: CustomTextStyles.bodyLargeBebas
                                  .copyWith(fontSize: 20.sp),
                            ),
                            Text(
                              "lbl_see_all".tr,
                              style: CustomTextStyles.bodyLargeBebas,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.w),
                    const _BuildPopulerExercises(),
                    SizedBox(height: 20.w),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BuildHeader extends StatelessWidget {
  const _BuildHeader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Positioned(
          top: -100,
          left: -80,
          child: CircleAvatar(
            radius: 140,
            backgroundColor: AppColor.white.withOpacity(0.1),
          ),
        ),
        Positioned(
          top: -20,
          left: -10,
          child: CircleAvatar(
            radius: 90,
            backgroundColor: AppColor.white.withOpacity(0.1),
          ),
        ),
        const _BuildHeaderComponents(),
      ],
    );
  }
}

class _BuildHeaderComponents extends StatelessWidget {
  const _BuildHeaderComponents();

  @override
  Widget build(BuildContext context) {
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Good Morning 🔥';
      }
      if (hour < 17) {
        return 'Good Afternoon 🔥';
      }
      return 'Good Evening 🔥';
    }

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting(),
                  style: CustomTextStyles.labelMedium.copyWith(
                    fontSize: 14.sp,
                    color: AppColor.black,
                  ),
                ),
                if (state.user != null && state.user!.name != null)
                  Text(
                    state.user!.name!,
                    style: CustomTextStyles.titleLargeDMSans.copyWith(
                      color: AppColor.black,
                    ),
                  ),
                SizedBox(height: 20.w),
                CustomSearchView(hintText: "lbl_search".tr)
              ],
            ));
      },
    );
  }
}

class _BuildStartExercise extends StatelessWidget {
  const _BuildStartExercise();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.w,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 250.w,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 180.w,
                      margin: EdgeInsets.only(bottom: 16.h),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 160.h,
                              margin: EdgeInsets.symmetric(horizontal: 20.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                gradient: LinearGradient(
                                  begin: const Alignment(0.5, 0),
                                  end: const Alignment(0.5, 1),
                                  colors: [
                                    AppColor.amber700,
                                    AppColor.orange700,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: AppImage.imgDumbell,
                            height: 73.w,
                            width: 73.w,
                            alignment: Alignment.bottomRight,
                            margin: EdgeInsets.only(right: 73.h),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(top: 30.w, right: 20.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 151.h,
                                    child: Text(
                                      "msg_fit_young_woman".tr,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyles.bodyLargeBebasW,
                                    ),
                                  ),
                                  SizedBox(height: 5.w),
                                  CustomElevatedButton(
                                    height: 30.w,
                                    width: 120.w,
                                    text: "lbl_start_exercise".tr,
                                    decoration: CustomButtonStyles.fillAmber,
                                    buttonTextStyle:
                                        CustomTextStyles.labelLargeDMSans,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: AppImage.imgStretching,
                    height: 249.h,
                    width: 195.h,
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "lbl_categories".tr,
                    style: CustomTextStyles.bodyLargeBebas
                        .copyWith(fontSize: 20.sp),
                  ),
                  Text(
                    "lbl_see_all".tr,
                    style: CustomTextStyles.bodyLargeBebas,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildCategory extends StatelessWidget {
  const _BuildCategory();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SizedBox(
          height: 100.w,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, index) => SizedBox(width: 20.w),
            itemCount: state.categoryList.length,
            itemBuilder: (context, index) {
              return CategoryItem(state.categoryList[index]);
            },
          ),
        );
      },
    );
  }
}

class _BuildPopulerExercises extends StatelessWidget {
  const _BuildPopulerExercises();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          separatorBuilder: (_, index) => SizedBox(height: 20.w),
          itemCount: state.exerciceList.length,
          itemBuilder: (context, index) {
            return ExercisecardItemWidget(state.exerciceList[index]);
          },
        );
      },
    );
  }
}

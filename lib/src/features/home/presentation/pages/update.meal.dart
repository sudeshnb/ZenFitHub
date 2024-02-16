import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/localization/app_localization.dart';
import 'package:zen_fit_hub/src/core/theme/custom.button.style.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';
import '../cubit/meal.update.cubit.dart';

class UpdateMealplanPage extends StatelessWidget {
  const UpdateMealplanPage({super.key, required this.model});
  final MealModel model;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealUpdateCubit()..init(model),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit a meal plan"),
        ),
        body: BlocBuilder<MealUpdateCubit, MealUpdateState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: REdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.w),
                    ShrinkButtonWithChild(
                      onPressed: () =>
                          context.read<MealUpdateCubit>().pickImage(),
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(100.h),
                        child: CustomImageView(
                          imagePath: state.image != null
                              ? state.image!.isNotEmpty
                                  ? state.image!
                                  : AppImage.imgMeal
                              : AppImage.imgMeal,
                          height: 120.w,
                          width: 120.w,
                          bgColor: AppColor.deepYellow,
                          fit: BoxFit.cover,
                          radius: BorderRadius.circular(100.h),
                        ),
                      ),
                    ),
                    const _BuildTitleTextEditor(),
                    const _BuildDescriptionTextEditor(),
                    const _BuildKaclTextEditor(),
                    const _BuildMinTextEditor(),
                    const _BuildProteinTextEditor(),
                    const _BuildCarbsTextEditor(),
                    const _BuildFatTextEditor(),
                    CustomElevatedButton(
                      text: "lbl_update".tr,
                      onPressed: () async {
                        context
                            .read<MealUpdateCubit>()
                            .update(context, model.id);
                      },
                      margin: REdgeInsets.symmetric(horizontal: 20.w),
                      decoration: CustomButtonStyles.fillGreen,
                    ),
                    SizedBox(height: 20.w),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BuildTitleTextEditor extends StatelessWidget {
  const _BuildTitleTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealUpdateCubit, MealUpdateState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "lbl_meal_name".tr,
              style: CustomTextStyles.titleLargeB,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
              child: CustomTextFormField(
                controller: state.title,
                height: 50.w,
                textInputType: TextInputType.name,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BuildDescriptionTextEditor extends StatelessWidget {
  const _BuildDescriptionTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealUpdateCubit, MealUpdateState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "lbl_meal_description".tr,
              style: CustomTextStyles.titleLargeB,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
              child: CustomTextFormField(
                controller: state.description,
                maxLines: 5,
                height: 150.w,
                textInputType: TextInputType.multiline,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BuildKaclTextEditor extends StatelessWidget {
  const _BuildKaclTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealUpdateCubit, MealUpdateState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "lbl_kcal".tr,
              style: CustomTextStyles.titleLargeB,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
              child: CustomTextFormField(
                controller: state.kcal,
                height: 50.w,
                textInputType: TextInputType.number,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BuildMinTextEditor extends StatelessWidget {
  const _BuildMinTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealUpdateCubit, MealUpdateState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "lbl_min".tr,
              style: CustomTextStyles.titleLargeB,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
              child: CustomTextFormField(
                controller: state.min,
                height: 50.w,
                textInputType: TextInputType.number,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BuildProteinTextEditor extends StatelessWidget {
  const _BuildProteinTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealUpdateCubit, MealUpdateState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "lbl_protein".tr,
              style: CustomTextStyles.titleLargeB,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
              child: CustomTextFormField(
                controller: state.protein,
                height: 50.w,
                textInputType: TextInputType.text,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BuildCarbsTextEditor extends StatelessWidget {
  const _BuildCarbsTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealUpdateCubit, MealUpdateState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "lbl_carbs".tr,
              style: CustomTextStyles.titleLargeB,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
              child: CustomTextFormField(
                controller: state.carbs,
                height: 50.w,
                textInputType: TextInputType.text,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BuildFatTextEditor extends StatelessWidget {
  const _BuildFatTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealUpdateCubit, MealUpdateState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "lbl_fat".tr,
              style: CustomTextStyles.titleLargeB,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
              child: CustomTextFormField(
                controller: state.fat,
                height: 50.w,
                textInputType: TextInputType.text,
              ),
            ),
          ],
        );
      },
    );
  }
}

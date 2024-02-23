import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/localization/app_localization.dart';
import 'package:zen_fit_hub/src/core/theme/custom.button.style.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';
import '../cubit/meal.cubit.dart';

class AddMealplanPage extends StatelessWidget {
  const AddMealplanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create a new meal plan"),
        ),
        body: BlocBuilder<MealCubit, MealState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: REdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.w),
                    ShrinkButtonWithChild(
                      onPressed: () => context.read<MealCubit>().pickImage(),
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(100.h),
                        child: state.file != null
                            ? Image.file(
                                state.file!,
                                height: 120.w,
                                width: 120.w,
                                fit: BoxFit.cover,
                              )
                            : CustomImageView(
                                imagePath: AppImage.imgMeal,
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
                      text: "lbl_save".tr,
                      onPressed: () =>
                          context.read<MealCubit>().create(context),
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
            // controller: state.title,
            onChanged: (value) => context.read<MealCubit>().getTitle(value),
            height: 50.w,
            textInputType: TextInputType.name,
          ),
        ),
      ],
    );
  }
}

class _BuildDescriptionTextEditor extends StatelessWidget {
  const _BuildDescriptionTextEditor();

  @override
  Widget build(BuildContext context) {
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
            // controller: state.description,
            onChanged: context.read<MealCubit>().getdescription,
            maxLines: 5,
            height: 150.w,
            textInputType: TextInputType.multiline,
          ),
        ),
      ],
    );
  }
}

class _BuildKaclTextEditor extends StatelessWidget {
  const _BuildKaclTextEditor();

  @override
  Widget build(BuildContext context) {
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
            // controller: state.kcal,
            onChanged: context.read<MealCubit>().getkcal,
            height: 50.w,
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}

class _BuildMinTextEditor extends StatelessWidget {
  const _BuildMinTextEditor();

  @override
  Widget build(BuildContext context) {
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
            // controller: state.min,
            onChanged: context.read<MealCubit>().getmin,
            height: 50.w,
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}

class _BuildProteinTextEditor extends StatelessWidget {
  const _BuildProteinTextEditor();

  @override
  Widget build(BuildContext context) {
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
            // controller: state.protein,
            onChanged: context.read<MealCubit>().getprotein,
            height: 50.w,
            textInputType: TextInputType.text,
          ),
        ),
      ],
    );
  }
}

class _BuildCarbsTextEditor extends StatelessWidget {
  const _BuildCarbsTextEditor();

  @override
  Widget build(BuildContext context) {
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
            // controller: state.carbs,
            onChanged: context.read<MealCubit>().getcarbs,
            height: 50.w,
            textInputType: TextInputType.text,
          ),
        ),
      ],
    );
  }
}

class _BuildFatTextEditor extends StatelessWidget {
  const _BuildFatTextEditor();

  @override
  Widget build(BuildContext context) {
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
            // controller: state.fat,
            onChanged: context.read<MealCubit>().getfat,
            height: 50.w,
            textInputType: TextInputType.text,
          ),
        ),
      ],
    );
  }
}

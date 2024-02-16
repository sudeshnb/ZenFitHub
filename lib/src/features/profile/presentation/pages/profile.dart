import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/quickalert.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/localization/app_localization.dart';
import 'package:zen_fit_hub/src/core/routes/routes.dart';
import 'package:zen_fit_hub/src/core/services/services.dart';
import 'package:zen_fit_hub/src/core/theme/app.decoration.dart';
import 'package:zen_fit_hub/src/core/theme/custom.button.style.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';
import 'package:zen_fit_hub/src/features/auth/presentation/bloc/auth/app_bloc.dart';
import 'package:zen_fit_hub/src/features/auth/presentation/cubit/user.cubit.dart';
import '../cubit/profile.cubit.dart';
import '../widgets/custom.drop.down.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => ProfileCubit()..init(state.user),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, pro) {
              return SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Text(
                        "lbl_profile".tr,
                        style: CustomTextStyles.titleLarge.copyWith(
                          color: AppColor.black,
                          fontSize: 22.sp,
                          fontFamily: 'Bebas',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20.w),
                      ShrinkButtonWithChild(
                        onPressed: () =>
                            context.read<ProfileCubit>().pickImageCamera(),
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(100.h),
                          child: Stack(
                            children: [
                              CustomImageView(
                                imagePath: pro.image ?? AppIcons.user,
                                height: 120.w,
                                width: 120.w,
                                bgColor: AppColor.deepYellow,
                                fit: BoxFit.cover,
                                radius: BorderRadius.circular(100.h),
                              ),
                              Container(
                                color: AppColor.black.withOpacity(0.2),
                                height: 120.w,
                                width: 120.w,
                                child: Icon(
                                  Icons.photo_camera,
                                  color: AppColor.white,
                                  size: 40.sp,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("lbl_full_name".tr,
                            style: CustomTextStyles.titleLargeB),
                      ),
                      const _BuildNameTextEditor(),
                      SizedBox(height: 10.w),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("lbl_phone".tr,
                            style: CustomTextStyles.titleLargeB),
                      ),
                      const _BuildPhoneTextEditor(),
                      SizedBox(height: 10.w),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("lbl_email_address".tr,
                              style: CustomTextStyles.titleLargeB)),
                      const _BuildEmailTextEditor(),
                      SizedBox(height: 10.w),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("lbl_weight".tr,
                              style: CustomTextStyles.titleLargeB)),
                      const _BuildWeightInput(),
                      SizedBox(height: 10.w),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("lbl_height".tr,
                              style: CustomTextStyles.titleLargeB)),
                      const _BuildHeightInput(),
                      SizedBox(height: 10.w),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("lbl_gender".tr,
                              style: CustomTextStyles.titleLargeB)),
                      SizedBox(height: 10.w),
                      CustomDropDown(
                          hintText: pro.gender,
                          height: 50.w,
                          items: [
                            "lbl_female".tr,
                            "lbl_male".tr,
                          ],
                          onChanged: (value) {
                            context.read<ProfileCubit>().gender(value);
                          }),
                      SizedBox(height: 10.w),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("lbl_age".tr,
                              style: CustomTextStyles.titleLargeB)),
                      const _BuildAgeTextEditor(),
                      SizedBox(height: 20.w),
                      const _BuildSaveButton(),
                      SizedBox(height: 20.w),
                      // const _BuildDeleteButton(),
                      CustomElevatedButton(
                          text: "lbl_logout".tr,
                          decoration: CustomButtonStyles.fillRed,
                          onPressed: () async {
                            await QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              title: 'Are you sure to logout?',
                              text:
                                  'Are you sure you want to logout this account?',
                              onConfirmBtnTap: () async {
                                context
                                    .read<AppBloc>()
                                    .add(const AppLogoutRequested());
                                NavigatorService.pushAndRemove(
                                    RoutesName.initial);
                              },
                            );
                          }),
                      SizedBox(height: 120.w),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _BuildSaveButton extends StatelessWidget {
  const _BuildSaveButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return CustomElevatedButton(
          text: "lbl_save".tr,
          onPressed: () async {
            await context
                .read<ProfileCubit>()
                .save(context)
                .then((value) => context.read<UserCubit>().init());
          },
        );
      },
    );
  }
}

// class _BuildDeleteButton extends StatelessWidget {
//   const _BuildDeleteButton();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfileCubit, ProfileState>(
//       builder: (context, state) {
//         return CustomElevatedButton(
//           decoration: CustomButtonStyles.fillRed,
//           text: "lbl_delete".tr,
//           onPressed: () async {
//             await QuickAlert.show(
//               context: context,
//               type: QuickAlertType.confirm,
//               title: 'Are you sure to delete?',
//               text: 'Are you sure you want to delete this account?',
//               onConfirmBtnTap: () async {
//                 await context
//                     .read<ProfileCubit>()
//                     .delete(context)
//                     .then((value) {
//                   context.read<AppBloc>().add(const AppLogoutRequested());
//                   NavigatorService.pushAndRemove(RoutesName.initial);
//                 });
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }

class _BuildNameTextEditor extends StatelessWidget {
  const _BuildNameTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: CustomTextFormField(
            controller: state.nameController,
            height: 50.w,
            maxLines: 1,
            textInputType: TextInputType.name,
          ),
        );
      },
    );
  }
}

class _BuildPhoneTextEditor extends StatelessWidget {
  const _BuildPhoneTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: CustomTextFormField(
            controller: state.phoneController,
            height: 50.w,
            textInputType: TextInputType.phone,
          ),
        );
      },
    );
  }
}

class _BuildEmailTextEditor extends StatelessWidget {
  const _BuildEmailTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: CustomTextFormField(
            controller: state.emailController,
            height: 50.w,
            textInputType: TextInputType.emailAddress,
          ),
        );
      },
    );
  }
}

class _BuildAgeTextEditor extends StatelessWidget {
  const _BuildAgeTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: CustomTextFormField(
            textInputType: TextInputType.number,
            height: 50.w,
            controller: state.ageController,
          ),
        );
      },
    );
  }
}

class _BuildHeightInput extends StatelessWidget {
  const _BuildHeightInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: CustomTextFormField(
            controller: state.height,
            height: 50.w,
            textInputType: TextInputType.number,
            suffix: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 7.w),
              decoration: AppDecoration.fillGray7001
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
              child: _buildCm(context, "lbl_cm".tr),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildCm(BuildContext context, String text) {
    return CustomElevatedButton(
      height: 30.w,
      width: 50.h,
      text: "lbl_cm".tr,
      decoration: CustomButtonStyles.fillOnPrimaryContainer,
      buttonTextStyle: CustomTextStyles.titleSmall,
    );
  }
}

class _BuildWeightInput extends StatelessWidget {
  const _BuildWeightInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: CustomTextFormField(
            controller: state.weight,
            height: 50.w,
            textInputType: TextInputType.number,
            suffix: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 7.w),
                decoration: AppDecoration.fillGray7001
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
                child: _buildCm()),
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildCm() {
    return CustomElevatedButton(
      height: 30.w,
      width: 50.h,
      text: "lbl_kg".tr,
      decoration: CustomButtonStyles.fillOnPrimaryContainer,
      buttonTextStyle: CustomTextStyles.titleSmall,
    );
  }
}

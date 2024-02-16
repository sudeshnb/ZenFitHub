import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/animation/animation.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/localization/app_localization.dart';
import 'package:zen_fit_hub/src/core/routes/routes.dart';
import 'package:zen_fit_hub/src/core/services/services.dart';
import 'package:zen_fit_hub/src/core/theme/custom.button.style.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/utils/utils.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';

import '../cubit/register.cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status.isDone) {
            NavigatorService.pushAndRemove(RoutesName.initial);
          }
          if (state.status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.err.toString())),
            );
          }
        },
        child: Scaffold(
          body: _SignupBody(),
          bottomNavigationBar: SizedBox(height: 80.w, child: const _Register()),
        ),
      ),
    );
  }
}

class _SignupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'lbl_create_accounts'.tr,
              style: CustomTextStyles.headlineLarge,
            ),
            Text(
              'msg_please_enter_your'.tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.titleSmallDMSansBluegray,
            ),
            SizedBox(height: 50.h),
            const _BuildEmailTextEditor(),
            SizedBox(height: 20.h),
            const _BuildPasswordTextEditor(),
            SizedBox(height: 20.h),
            const _BuildLoginButton(),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.84,
                child: Text(
                  "msg_or_register_with".tr,
                  style: CustomTextStyles.labelLarge,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            const _BuildConnectWithGoogle(),
            SizedBox(height: 10.h),
            const _BuildConnectWithFacebook(),
          ],
        ),
      ),
    );
  }
}

class _BuildEmailTextEditor extends StatelessWidget {
  const _BuildEmailTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, emailController) {
        return CustomTextFormField(
            hintText: "lbl_email".tr,
            onChanged: context.read<RegisterCubit>().email,
            textInputType: TextInputType.emailAddress,
            suffix: Container(
                margin: EdgeInsets.only(right: 20.w),
                child: const CustomImageView(imagePath: AppIcons.email)),
            validator: (value) {
              if (value == null || (!isValidEmail(value, isRequired: true))) {
                return "err_msg_please_enter_valid_email".tr;
              }
              return null;
            });
      },
    );
  }
}

class _BuildPasswordTextEditor extends StatelessWidget {
  const _BuildPasswordTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return CustomTextFormField(
            onChanged: context.read<RegisterCubit>().password,
            hintText: "lbl_password".tr,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            suffix: InkWell(
              onTap: () => context.read<RegisterCubit>().changeVisibility(),
              child: Container(
                margin: EdgeInsets.only(right: 20.w),
                child: CustomImageView(
                    imagePath:
                        state.isShowPassword ? AppIcons.hide : AppIcons.show),
              ),
            ),
            validator: (value) {
              if (value == null ||
                  (!isValidPassword(value, isRequired: true))) {
                return "err_msg_please_enter_valid_password".tr;
              }
              return null;
            },
            obscureText: state.isShowPassword);
      },
    );
  }
}

class _BuildLoginButton extends StatelessWidget {
  const _BuildLoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        if (state.status.loading) {
          return DefualtLoading.dots;
        }
        return CustomElevatedButton(
          text: "lbl_create_account".tr,
          buttonTextStyle: CustomTextStyles.titleLargeBebas,
          onPressed: () => context.read<RegisterCubit>().register(),
        );
      },
    );
  }
}

class _BuildConnectWithGoogle extends StatelessWidget {
  const _BuildConnectWithGoogle();

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      text: "msg_connect_with_google".tr,
      leftIcon: Container(
        margin: EdgeInsets.only(right: 30.w),
        child: const CustomImageView(imagePath: AppIcons.google),
      ),
      onPressed: () => context.read<RegisterCubit>().loginWithGoogle(),
    );
  }
}

class _BuildConnectWithFacebook extends StatelessWidget {
  const _BuildConnectWithFacebook();

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: "msg_connect_with_facebook".tr,
      leftIcon: Container(
        margin: EdgeInsets.only(right: 30.w),
        child: const CustomImageView(imagePath: AppIcons.facebook),
      ),
      decoration: CustomButtonStyles.fillIndigo,
      // onPressed: () => context.read<RegisterCubit>().loginWithFacebook(),
    );
  }
}

class _Register extends StatelessWidget {
  const _Register();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorService.goBack(),
      child: Align(
        alignment: Alignment.center,
        child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "msg_already_have_an".tr,
                  style: CustomTextStyles.titleSmall,
                ),
                TextSpan(
                  text: "lbl_login".tr,
                  style: CustomTextStyles.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            textAlign: TextAlign.left),
      ),
    );
  }
}

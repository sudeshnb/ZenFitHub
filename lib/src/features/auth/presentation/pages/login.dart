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
import '../cubit/login.cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: _LoginBody(),
        bottomNavigationBar: SizedBox(height: 80.w, child: const _Register()),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.done) {
            NavigatorService.pushAndRemove(RoutesName.main);
          }
          if (state.status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.err.toString())),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'msg_welcome_to_pro_fitness'.tr,
                style: CustomTextStyles.headlineLarge,
              ),
              Text(
                'msg_hello_there_sign'.tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.titleSmallDMSansBluegray,
              ),
              SizedBox(height: 50.h),
              const _BuildEmailTextEditor(),
              SizedBox(height: 20.h),
              const _BuildPasswordTextEditor(),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "msg_forgot_password".tr,
                  style: CustomTextStyles.titleSmall,
                ),
              ),
              SizedBox(height: 20.h),
              const _BuildLoginButton(),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 0.84,
                  child: Text(
                    "lbl_or_login_with".tr,
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
      ),
    );
  }
}

class _BuildEmailTextEditor extends StatelessWidget {
  const _BuildEmailTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, emailController) {
        return CustomTextFormField(
          hintText: "lbl_email".tr,
          textInputType: TextInputType.emailAddress,
          onChanged: context.read<LoginCubit>().email,
          suffix: Container(
              margin: EdgeInsets.only(right: 20.w),
              child: const CustomImageView(imagePath: AppIcons.email)),
          validator: (value) {
            if (value == null || (!isValidEmail(value, isRequired: true))) {
              return "err_msg_please_enter_valid_email".tr;
            }
            return null;
          },
        );
      },
    );
  }
}

class _BuildPasswordTextEditor extends StatelessWidget {
  const _BuildPasswordTextEditor();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return CustomTextFormField(
            hintText: "lbl_password".tr,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            onChanged: context.read<LoginCubit>().password,
            suffix: InkWell(
              onTap: () => context.read<LoginCubit>().changeVisibility(),
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
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state.status.loading) {
          return DefualtLoading.dots;
        }
        return CustomElevatedButton(
          text: "lbl_login".tr,
          buttonTextStyle: CustomTextStyles.titleLargeBebas,
          onPressed: () => context.read<LoginCubit>().login(),
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
      onPressed: () => context.read<LoginCubit>().loginWithGoogle(),
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
      // onPressed: () => context.read<LoginCubit>().loginWithFacebook(),
    );
  }
}

class _Register extends StatelessWidget {
  const _Register();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorService.push(RoutesName.signUpScreen),
      child: Align(
        alignment: Alignment.center,
        child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "lbl_don_t_have_an_account".tr,
                  style: CustomTextStyles.titleSmall,
                ),
                TextSpan(
                  text: "lbl_register".tr,
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

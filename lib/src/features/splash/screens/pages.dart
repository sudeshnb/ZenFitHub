import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/localization/app_localization.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';
import '../../auth/presentation/bloc/auth/app_bloc.dart';
import '../cubit/splash.cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<AppBloc>().state.status;
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit()..execute(context),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 348.h,
                      child: Stack(
                        children: [
                          CustomImageView(
                              imagePath: AppImage.imgVector2,
                              height: 158.h,
                              width: 179.w,
                              alignment: Alignment.bottomLeft),
                          CustomImageView(
                              imagePath: AppImage.imgVector3,
                              height: 158.h,
                              width: 179.w,
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top: 44.w, right: 18.h)),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 161.h,
                              width: 169.h,
                              decoration: BoxDecoration(
                                color: AppColor.deepOrange,
                                borderRadius: BorderRadius.circular(84.h),
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: AppImage.imgGirlDoingBice,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "lbl_zen".tr,
                              style: CustomTextStyles.displayMedium),
                          TextSpan(
                            text: "lbl_fithub".tr,
                            style: CustomTextStyles.displayMedium.copyWith(
                              color: AppColor.green,
                            ),
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        "msg_we_train_your_body".tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

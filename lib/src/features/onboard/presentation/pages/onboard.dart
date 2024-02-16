import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/animation/animation.dart';
import 'package:zen_fit_hub/src/core/constants/colors.dart';
import 'package:zen_fit_hub/src/core/localization/app_localization.dart';
import 'package:zen_fit_hub/src/core/routes/routes.dart';
import 'package:zen_fit_hub/src/core/services/services.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';

import '../cubit/pageview.onboard.dart';
import '../widgets/bottom.card.dart';

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnBoardingBody();
  }
}

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardPageViewCubit()..fetchData(),
      child: BlocBuilder<OnboardPageViewCubit, OnboardPageViewState>(
        builder: (context, state) {
          final bool isNotLast = (state.onboards.length - 1 != state.index);
          return Scaffold(
            appBar: OnBoardingAppBar(isNotLast: isNotLast, state: state),
            body: Stack(
              children: [
                const OnBoardMainImageList(),
                const OnBoardBottom(),
                OnBoardTextArea(state: state),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OnBoardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OnBoardingAppBar(
      {super.key, required this.isNotLast, required this.state});
  final bool isNotLast;
  final OnboardPageViewState state;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      actions: [
        if (isNotLast && state.index > 0)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 10.h),
            child: TextButton(
              child: Text(
                "lbl_skip".tr,
                style:
                    CustomTextStyles.titleLarge.copyWith(color: AppColor.black),
              ),
              onPressed: () => onPressed(context),
            ),
          )
      ],
    );
  }

  void onPressed(BuildContext context) {
    if (!isNotLast) return;
    context.read<OnboardPageViewCubit>().clickSkip();
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class OnBoardMainImageList extends StatelessWidget {
  const OnBoardMainImageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardPageViewCubit, OnboardPageViewState>(
      builder: (context, state) {
        return PageView.builder(
          itemCount: state.onboards.length,
          controller: state.imageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return OnBoardMainImage(
              image: state.onboards[index].image!,
            );
          },
        );
      },
    );
  }
}

class OnBoardMainImage extends StatelessWidget {
  const OnBoardMainImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return OpacityTranslateAnimation(
      duration: const Duration(milliseconds: 1800),
      child: Align(
        alignment: const Alignment(0, -0.8),
        child: CustomImageView(imagePath: image, height: 300.h),
      ),
    );
  }
}

class OnBoardBottom extends StatelessWidget {
  const OnBoardBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardPageViewCubit, OnboardPageViewState>(
      listener: (context, state) {
        if (state.isLast) {
          NavigatorService.pushAndRemove(RoutesName.onboardEnd);
        }
      },
      builder: (context, state) {
        return const OnBoardBottomCard(child: SizedBox());
      },
    );
  }
}

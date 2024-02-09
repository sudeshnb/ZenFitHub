import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/animation/animation.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/features/onboard/data/models/model.dart';

import '../cubit/pageview.onboard.dart';

///
class OnBoardBottomCard extends StatelessWidget {
  const OnBoardBottomCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 250.h,
        child: Center(child: child),
      ),
    );
  }
}

///
class OnBoardTextArea extends StatelessWidget {
  const OnBoardTextArea({super.key, required this.state});
  final OnboardPageViewState state;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 250.h,
        child: Column(
          children: [
            OnBoardTextList(state: state),
            const BottonsAndIndicator(),
          ],
        ),
      ),
    );
  }
}

class OnBoardTextList extends StatelessWidget {
  const OnBoardTextList({super.key, required this.state});
  final OnboardPageViewState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.onboards.length,
        controller: state.textController,
        itemBuilder: (context, index) {
          return OnBoardTextListCard(
            model: state.onboards[state.index],
          );
        },
      ),
    );
  }
}

class OnBoardTextListCard extends StatelessWidget {
  const OnBoardTextListCard({super.key, required this.model});
  final OnBoardModel model;

  @override
  Widget build(BuildContext context) {
    return OpacityTranslateAnimation(
      duration: const Duration(milliseconds: 2000),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: model.first,
                style: CustomTextStyles.displayMedium,
              ),
              const TextSpan(text: ' '),
              TextSpan(
                text: '${model.center}\n',
                style: CustomTextStyles.displayMedium
                    .copyWith(color: AppColor.green),
              ),
              TextSpan(
                text: model.end,
                style: CustomTextStyles.displayMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
class BottonsAndIndicator extends StatelessWidget {
  const BottonsAndIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardPageViewCubit, OnboardPageViewState>(
      builder: (context, state) {
        final bool isNotLast = (state.onboards.length - 1 != state.index);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 90.w,
                child: TextButton(
                  child: Text(
                    (state.index > 0) ? 'Back' : 'Skip',
                    style: CustomTextStyles.titleLarge
                        .copyWith(color: AppColor.black),
                  ),
                  onPressed: () =>
                      _leftPressed(context, isFirst: state.index > 0),
                ),
              ),
              DotIndicatorBar(
                  length: state.onboards.length,
                  index: state.index,
                  activeColor: AppColor.green,
                  idleColor: AppColor.black.withOpacity(0.1)),
              TextButton(
                onPressed: () => _rightPressed(context, isNotLast: isNotLast),
                child: Container(
                  width: 90.w,
                  alignment: Alignment.centerRight,
                  child: Text(
                    !isNotLast ? 'Start' : 'Next',
                    style: CustomTextStyles.titleLarge
                        .copyWith(color: AppColor.black),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _rightPressed(BuildContext context, {bool isNotLast = false}) async {
    if (isNotLast) {
      context.read<OnboardPageViewCubit>().clickNext();
    } else {
      context.read<OnboardPageViewCubit>().clickSkip();
    }
  }

  _leftPressed(BuildContext context, {bool isFirst = false}) async {
    if (isFirst) {
      context.read<OnboardPageViewCubit>().clickBack();
    } else {
      context.read<OnboardPageViewCubit>().clickSkip();
    }
  }
}

class DotIndicatorBar extends StatelessWidget {
  const DotIndicatorBar(
      {super.key,
      required this.index,
      required this.length,
      required this.activeColor,
      required this.idleColor});
  final int index;
  final int length;
  final Color activeColor;
  final Color idleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(length, (now) => _indicator(index != now)),
    );
  }

  Widget _indicator(bool isClick) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: CircleAvatar(
        radius: 4.sp,
        backgroundColor: isClick ? idleColor : activeColor,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';
import 'package:zen_fit_hub/src/features/main/source/source.dart';

import '../cubit/bottom.navigation.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        return Container(
          height: 75.w,
          decoration: BoxDecoration(color: AppColor.white),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0,
            elevation: 0,
            currentIndex: state.index,
            type: BottomNavigationBarType.fixed,
            items: List.generate(bottomMenuList.length, (index) {
              return BottomNavigationBarItem(
                icon: Opacity(
                  opacity: 0.5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: bottomMenuList[index].icon,
                        height: 24.w,
                        width: 24.w,
                        color: AppColor.blueGray900,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.w),
                        child: Text(
                          bottomMenuList[index].title ?? "",
                          style: CustomTextStyles.labelLarge.copyWith(
                            color: AppColor.blueGray900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                activeIcon: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImageView(
                      imagePath: bottomMenuList[index].activeIcon,
                      height: 22.w,
                      width: 24.w,
                      color: AppColor.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 11.w),
                      child: Text(
                        bottomMenuList[index].title ?? "",
                        style: CustomTextStyles.labelLarge.copyWith(
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ],
                ),
                label: '',
              );
            }),
            onTap: (index) {
              // selectedIndex = index;
              context.read<BottomNavigationCubit>().jump(index);
              // widget.onChanged?.call(bottomMenuList[index].type);
              // setState(() {});
            },
          ),
        );
      },
    );
  }
}

enum BottomBarEnum { home, mealplans, exercise, profile }

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

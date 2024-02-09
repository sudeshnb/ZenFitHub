import 'package:zen_fit_hub/src/core/constants/constants.dart';
import 'package:zen_fit_hub/src/core/localization/app_localization.dart';

import '../widget/custom.bottom.bar.dart';

List<BottomMenuModel> bottomMenuList = [
  BottomMenuModel(
    icon: AppIcons.home,
    activeIcon: AppIcons.home,
    title: "lbl_home".tr,
    type: BottomBarEnum.home,
  ),
  BottomMenuModel(
    icon: AppIcons.meal,
    activeIcon: AppIcons.meal,
    title: "lbl_meal_plans".tr,
    type: BottomBarEnum.mealplans,
  ),
  BottomMenuModel(
    icon: AppIcons.exercice,
    activeIcon: AppIcons.exercice,
    title: "lbl_exercise".tr,
    type: BottomBarEnum.exercise,
  ),
  BottomMenuModel(
    icon: AppIcons.profile,
    activeIcon: AppIcons.profile,
    title: "lbl_profile".tr,
    type: BottomBarEnum.profile,
  )
];

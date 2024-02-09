import 'package:flutter/widgets.dart';
import 'package:zen_fit_hub/src/core/constants/constants.dart';

import 'prograssive_dots.dart';
import 'two_rotating_arc.dart';

class DefualtLoading {
  ///
  static final arc = Align(
    alignment: Alignment.center,
    child: TwoRotatingArc(size: 50, color: AppColor.green),
  );

  ///
  static final dots = Align(
    alignment: Alignment.center,
    child: PrograssiveDots(color: AppColor.green, size: 50.0),
  );
}

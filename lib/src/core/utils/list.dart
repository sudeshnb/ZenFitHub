import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ListX on List<Widget> {
  List<Widget> verticalGap(double space) {
    return length <= 1
        ? this
        : sublist(1).fold(
            [first],
            (previous, element) =>
                [...previous, SizedBox(height: 20.w), element],
          );
  }
}

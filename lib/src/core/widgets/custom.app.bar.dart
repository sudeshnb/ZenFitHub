import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';

import '../constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  final double? height;
  final String? title;
  final Widget? action;
  final Widget? bottom;

  final Widget? pre;

  const CustomAppBar({
    super.key,
    this.pre,
    this.height,
    this.title,
    this.bottom,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: height ?? 56.w,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pre ?? const Spacer(),
              if (title != null)
                Text(title!,
                    style: CustomTextStyles.titleLarge.copyWith(
                      color: AppColor.black,
                      fontSize: 22.sp,
                      fontFamily: 'Bebas',
                      fontWeight: FontWeight.w400,
                    )),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: action ?? const Spacer(),
                ),
              ),
            ],
          ),
          if (bottom != null) ...[
            SizedBox(height: 20.w),
            bottom!,
            SizedBox(height: 20.w)
          ],
        ],
      ),
    );
  }
}

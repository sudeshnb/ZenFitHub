import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/theme/custom.text.style.dart';
import 'package:zen_fit_hub/src/core/widgets/widgets.dart';
import 'package:zen_fit_hub/src/features/home/data/models/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(this.model, {Key? key}) : super(key: key);

  final CategoryModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 61.w,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(bottom: 2.w),
          child: Column(
            children: [
              CustomImageView(
                imagePath: model.image,
                height: 61.w,
                width: 61.w,
                fit: BoxFit.cover,
                radius: BorderRadius.circular(30.h),
              ),
              const SizedBox(height: 11.2),
              Text(
                model.name,
                style: CustomTextStyles.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

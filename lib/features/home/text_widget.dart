import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/styles.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 11.h),
        Text(
          text,
          style: AppStyles.titleL
              .copyWith(color: AppColor.blackColor, fontSize: 13.sp),
        ),
        SizedBox(height: 7.h),
      ],
    );
  }
}

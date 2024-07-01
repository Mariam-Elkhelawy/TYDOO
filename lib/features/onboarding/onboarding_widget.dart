import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/features/onboarding/gradient_text.dart';

class OnboardingWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const OnboardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 370.w,
            height: 370.h,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 24.h),
          GradientText(
            title,
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,color: AppColor.gradient[2]
            ),
          ),
        ],
      ),
    );
  }
}

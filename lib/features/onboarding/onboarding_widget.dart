import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      padding:  EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image,width: 370.w,height: 370.h,),
          SizedBox(height: 24.h),
          GradientText(
            title,
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFebd8e7),
                Color(0xFF9b8596),
                Color(0xFF413076),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

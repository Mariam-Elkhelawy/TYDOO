import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/styles.dart';

class SignWithWidget extends StatelessWidget {
  const SignWithWidget(
      {super.key, required this.iconPath, required this.iconText});
  final String iconPath;
  final String iconText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 45.h,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 13,
              offset: const Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Image.asset(iconPath,width: 24.w,height: 24.h,),
            ),
            SizedBox(width: 50.w),
            Text(
              iconText,
              style: AppStyles.regularText.copyWith(fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}

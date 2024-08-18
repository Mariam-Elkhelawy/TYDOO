import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/providers/my_provider.dart';

class SignWithWidget extends StatelessWidget {
  const SignWithWidget(
      {super.key, required this.iconPath, required this.iconText});
  final String iconPath;
  final String iconText;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 45.h,
        decoration: BoxDecoration(
          color: provider.themeMode==ThemeMode.light?AppColor.whiteColor:AppColor.darkColor,
          boxShadow: [
            BoxShadow(
              color:  provider.themeMode==ThemeMode.light?Colors.grey.withOpacity(.4):AppColor.taskGreyColor.withOpacity(.15),
              blurRadius: 13,
              offset: const Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 20.w),
              child: Image.asset(iconPath,width: 24.w,height: 24.h,),
            ),
            SizedBox(width: 50.w),
            Text(
              iconText,
              style: AppStyles.regularText.copyWith(fontSize: 15.sp,color:  provider.themeMode==ThemeMode.light?AppColor.blackColor:AppColor.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

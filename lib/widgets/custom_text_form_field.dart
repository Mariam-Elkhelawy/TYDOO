import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/providers/my_provider.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.myController,
      this.hintText = '',
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.keyboardType,
      this.onValidate});
  TextEditingController? myController = TextEditingController();
  String hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool obscureText;
  TextInputType? keyboardType;
  String? Function(String?)? onValidate;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return TextFormField(
      textDirection:
          provider.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppStyles.generalText.copyWith(
          fontSize: 12.sp,
          color: provider.themeMode == ThemeMode.light
              ? AppColor.primaryColor
              : AppColor.primaryDarkColor),
      validator: onValidate,
      controller: myController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: AppStyles.hintText.copyWith(
          color: provider.themeMode == ThemeMode.light
              ? AppColor.blackColor.withOpacity(.5)
              : AppColor.whiteColor.withOpacity(.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColor.borderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(width: 1.5, color: AppColor.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColor.borderColor),
        ),
      ),
    );
  }
}

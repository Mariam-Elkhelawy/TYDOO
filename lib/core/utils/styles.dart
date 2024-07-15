import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/app_colors.dart';

class AppStyles {
  static TextStyle titleL = GoogleFonts.inter(
      fontSize: 24.sp,
      fontWeight: FontWeight.w800,
      color: AppColor.whiteColor,
      ); static TextStyle bodyL = GoogleFonts.inter(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: AppColor.blackColor,
      );
  static TextStyle bodyM = GoogleFonts.inter(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.blackColor,
      );
  static TextStyle bodyS = GoogleFonts.inter(
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.whiteColor,
    letterSpacing: -.4
      );
  static TextStyle regularText = GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.blackColor,
      letterSpacing: -.4);
  static TextStyle generalText = GoogleFonts.inter(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.primaryColor,
      );
  static TextStyle hintText = GoogleFonts.inter(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.blackColor.withOpacity(.5),
      );
  static TextStyle settingTitle = GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.blackColor,
      );

}

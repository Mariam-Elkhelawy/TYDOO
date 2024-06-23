import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/utils/app_colors.dart';

class ActiveIcon extends StatelessWidget {
  const ActiveIcon({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      width: 24.w,
      height: 24.h,
      colorFilter:
      const ColorFilter.mode(AppColor.primaryColor, BlendMode.srcIn),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});
  static const String routeName = 'AddTask';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.addTaskBG), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const ImageIcon(
                AssetImage(AppImages.arrow),size: 20,
                color: AppColor.iconColor,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Add Task',
            style: AppStyles.bodyL.copyWith(color: AppColor.primaryColor),
          ),actions: [
          Padding(
            padding: EdgeInsets.only(right: 24.w),
            child: const Icon(Icons.notifications,              color: AppColor.iconColor,
            ),

          )

        ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/data/models/task_model.dart';
import 'package:todo_app/features/home/task_item.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/providers/my_provider.dart';

class ImportantTab extends StatelessWidget {
  const ImportantTab({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var provider = Provider.of<MyProvider>(context);

    return Column(
      children: [
        SizedBox(height: 75.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ImageIcon(
                const AssetImage(AppImages.search),
                color: provider.themeMode == ThemeMode.light
                    ? AppColor.taskGreyColor
                    : AppColor.whiteColor,
              ),
              Text(
                local.important,
                style: AppStyles.bodyL.copyWith(
                    color: provider.themeMode == ThemeMode.light
                        ? AppColor.primaryColor
                        : AppColor.primaryDarkColor),
              ),
              ImageIcon(
                const AssetImage(AppImages.sort),
                color: provider.themeMode == ThemeMode.light
                    ? AppColor.taskGreyColor
                    : AppColor.whiteColor,
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseFunctions.getImportantTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    local.error,
                    style: AppStyles.titleL.copyWith(
                        fontSize: 14.sp,
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.primaryColor
                            : AppColor.primaryDarkColor),
                  ),
                );
              }
              var tasks =
                  snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
              if (tasks.isEmpty) {
                return Column(
                  children: [
                    SizedBox(height: 130.h),
                    Image.asset(
                      AppImages.empty,
                      width: 239.w,
                      height: 239.h,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      local.noImportant,
                      style: AppStyles.titleL.copyWith(
                          fontSize: 14.sp,     color: provider.themeMode == ThemeMode.light
                          ? AppColor.primaryColor
                          : AppColor.primaryDarkColor),
                    )
                  ],
                );
              }

              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    TaskModel task = tasks[index];
                    return TaskItem(taskModel: task);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/data/models/task_model.dart';
import 'package:todo_app/features/home/task_item.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImportantTab extends StatelessWidget {
  const ImportantTab({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return Column(
      children: [
        SizedBox(height: 75.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ImageIcon(
                AssetImage(AppImages.search),
                color: AppColor.taskGreyColor,
              ),
              Text(
                'Important',
                style: AppStyles.bodyL.copyWith(color: AppColor.primaryColor),
              ),
              const ImageIcon(
                AssetImage(AppImages.sort),
                color: AppColor.taskGreyColor,
              ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot<TaskModel>>(
          stream: FirebaseFunctions.getImportantTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),);
            }

            if (snapshot.hasError) {
              return Center(child: Text(local.error, style: AppStyles.titleL.copyWith(
                  fontSize: 14.sp, color: AppColor.primaryColor),
              ));
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
                    local.noTasks,
                    style: AppStyles.titleL.copyWith(
                        fontSize: 14.sp, color: AppColor.primaryColor),
                  )
                ],
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                TaskModel task = tasks[index];
                return TaskItem(taskModel: task);
              },
            );
          },
        ),
      ],
    );
  }
}

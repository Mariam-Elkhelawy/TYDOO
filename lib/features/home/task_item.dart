import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/data/models/task_model.dart';
import 'package:todo_app/features/home/edit_tasks_screen.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 25.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
              color: AppColor.blackColor.withOpacity(.11),
              spreadRadius: 0,
              offset: const Offset(0, 0),
              blurRadius: 16)
        ],
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .3,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                  bottomLeft: provider.languageCode == 'en'
                      ? Radius.circular(12.r)
                      : Radius.zero,
                  topLeft: provider.languageCode == 'en'
                      ? Radius.circular(12.r)
                      : Radius.zero,
                  bottomRight: provider.languageCode == 'ar'
                      ? Radius.circular(12.r)
                      : Radius.zero,
                  topRight: provider.languageCode == 'ar'
                      ? Radius.circular(12.r)
                      : Radius.zero),
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialog(
                        is2Actions: true,
                        icon: const Icon(
                          Icons.warning,
                          color: Colors.amberAccent,
                        ),
                        actionRequired: () async {
                          await FirebaseFunctions.deleteTask(taskModel.id);
                        },
                        dialogContent: local.deleteAlert,
                        dialogTitle: local.alert);
                  },
                );
              },
              backgroundColor: AppColor.deleteColor,
              icon: Icons.delete,
              label: local.delete,
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: .32,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                  bottomRight: provider.languageCode == 'en'
                      ? Radius.circular(12.r)
                      : Radius.zero,
                  topRight: provider.languageCode == 'en'
                      ? Radius.circular(12.r)
                      : Radius.zero,
                  bottomLeft: provider.languageCode == 'ar'
                      ? Radius.circular(12.r)
                      : Radius.zero,
                  topLeft: provider.languageCode == 'ar'
                      ? Radius.circular(12.r)
                      : Radius.zero),
              autoClose: false,
              onPressed: (context) async {
                taskModel.isImportant = !taskModel.isImportant;
                await FirebaseFunctions.updateTask(taskModel);
              },
              backgroundColor: AppColor.importantBGColor,
              icon: taskModel.isImportant ? Icons.star : Icons.star_border,
              label: local.important,
              foregroundColor: AppColor.importantColor,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: provider.themeMode == ThemeMode.light
                ? AppColor.whiteColor
                : AppColor.inactiveColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                width: 8.w,
                height: 83.h,
                decoration: BoxDecoration(
                  color: taskModel.taskColor,
                  borderRadius: BorderRadius.only(
                    topLeft: provider.languageCode == 'en'
                        ? Radius.circular(12.r)
                        : Radius.circular(0.r),
                    bottomLeft: provider.languageCode == 'en'
                        ? Radius.circular(12.r)
                        : Radius.circular(0.r),
                    bottomRight: provider.languageCode == 'en'
                        ? Radius.circular(0.r)
                        : Radius.circular(12.r),
                    topRight: provider.languageCode == 'en'
                        ? Radius.circular(0.r)
                        : Radius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () async {
                  taskModel.isDone = !taskModel.isDone;
                  await FirebaseFunctions.updateTask(taskModel);
                },
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: taskModel.isDone
                        ? AppColor.doneColor
                        : Colors.transparent,
                    border: Border.all(
                        color: taskModel.isDone
                            ? Colors.transparent
                            : provider.themeMode == ThemeMode.light
                                ? AppColor.primaryColor
                                : AppColor.primaryDarkColor),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 16,
                    color: !taskModel.isDone
                        ? Colors.transparent
                        : AppColor.whiteColor,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      taskModel.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.titleL.copyWith(
                          fontSize: 14.sp,
                          color: provider.themeMode == ThemeMode.light
                              ? AppColor.primaryColor
                              : AppColor.primaryDarkColor),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '${taskModel.startTime ?? ''} - ${taskModel.endTime ?? ''}',
                      style: AppStyles.generalText.copyWith(
                          fontSize: 12.sp, color: AppColor.taskGreyColor),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    EditTaskScreen.routeName,
                    arguments: TaskModel(
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        categoryId: '',
                        id: taskModel.id,
                        title: taskModel.title,
                        date: taskModel.date,
                        description: taskModel.description,
                        startTime: taskModel.startTime,
                        endTime: taskModel.endTime),
                  );
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 16.w),
                  child: const ImageIcon(
                    AssetImage(
                      AppImages.edit,
                    ),
                    color: AppColor.taskGreyColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

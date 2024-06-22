import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/tasks/edit_tasks_screen.dart';
import 'package:todo_app/features/models/task_model.dart';
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
        boxShadow: [
          BoxShadow(
              color: AppColor.blackColor.withOpacity(.11),
              spreadRadius: 0,
              offset: const Offset(0, 0),
              blurRadius: 16)
        ],
        color: taskModel.isDone
            ? const Color(0xFFFE4A49)
            : provider.languageCode == 'en'
                ? const Color(0xFF21B7CA)
                : const Color(0xFFFE4A49),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: taskModel.isDone ? .3 : .5,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                topLeft: Radius.circular(15.r),
              ),
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
              backgroundColor: const Color(0xFFFE4A49),
              icon: Icons.delete,
              label: local.delete,
            ),
              SlidableAction(
                borderRadius: BorderRadius.circular(15.r),
                onPressed: (context) {
                  Navigator.pushNamed(
                    context,
                    EditTaskScreen.routeName,
                    arguments: TaskModel(
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        id: taskModel.id,
                        title: taskModel.title,
                        date: taskModel.date,
                        description: taskModel.description,
                        startTime: taskModel.startTime,
                        endTime: taskModel.endTime),
                  );
                },
                backgroundColor: const Color(0xFF21B7CA),
                icon: Icons.star_border,
                label: local.edit,
              ),
          ],
        ),
        child: Container(
          // height: MediaQuery.of(context).size.height * .14,
          decoration: BoxDecoration(
            color: provider.themeMode == ThemeMode.light
                ? AppColor.whiteColor
                : AppTheme.blackColor,
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
                      topLeft: Radius.circular(12.r),
                      bottomLeft: Radius.circular(12.r)),
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
                        : AppColor.whiteColor,
                    border: Border.all(
                        color: taskModel.isDone
                            ? Colors.transparent
                            : AppColor.primaryColor),
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 16,
                    color: AppColor.whiteColor,
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
                          fontSize: 14.sp, color: AppColor.primaryColor),
                    ),
                    // Text(
                    //   taskModel.description,
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    //    style: AppStyles.generalText.copyWith(
                    // fontSize: 12.sp, color: AppColor.taskGreyColor,
                    // ),),
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
                        id: taskModel.id,
                        title: taskModel.title,
                        date: taskModel.date,
                        description: taskModel.description,
                        startTime: taskModel.startTime,
                        endTime: taskModel.endTime),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: const ImageIcon(
                    AssetImage(
                      'assets/images/Edit.png',
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

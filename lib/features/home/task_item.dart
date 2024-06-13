import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/core/utils/app_colors.dart';
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
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;

    return Container(
      margin:
          const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: AppColor.blackColor.withOpacity(.11),
              spreadRadius: 0,
              offset: Offset(0, 0),
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
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                topLeft: Radius.circular(15),
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
            if (!taskModel.isDone)
              SlidableAction(
                borderRadius: BorderRadius.circular(15),
                onPressed: (context) {
                  Navigator.pushNamed(
                    context,
                    EditTaskScreen.routeName,
                    arguments: TaskModel(
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        id: taskModel.id,
                        title: taskModel.title,
                        date: taskModel.date,
                        taskColor: Colors.red,
                        description: taskModel.description),
                  );
                },
                backgroundColor: const Color(0xFF21B7CA),
                icon: Icons.edit,
                label: local.edit,
              ),
          ],
        ),
        child: Container(

          // height: MediaQuery.of(context).size.height * .14,
          decoration: BoxDecoration(
            color: provider.themeMode == ThemeMode.light
                ? Colors.white
                : AppTheme.blackColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                width: 8.w,
                height: 83.h,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius:BorderRadius.only(topLeft: Radius.circular(12.r),bottomLeft: Radius.circular(12.r)),
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () async {
                  taskModel.isDone = !taskModel.isDone;
                  await FirebaseFunctions.updateTask(taskModel);
                },
                child: taskModel.isDone
                    ? Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00C400),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 16,
                          color: AppColor.whiteColor,
                        ),
                      )
                    : Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.whiteColor,
                            border: Border.all(color: AppColor.primaryColor)),
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
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColor.primaryColor,
                      ),
                    ),
                    // Text(
                    //   taskModel.description,
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: theme.textTheme.bodyMedium
                    //       ?.copyWith(fontWeight: FontWeight.w500),
                    // ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat.yMMMd(
                                  provider.languageCode == 'en' ? 'en' : 'ar')
                              .format(taskModel.date),
                          style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

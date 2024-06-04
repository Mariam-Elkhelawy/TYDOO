import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
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
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 20, vertical: 10),
          height: MediaQuery.of(context).size.height * .14,
          decoration: BoxDecoration(
            color: provider.themeMode == ThemeMode.light
                ? Colors.white
                : AppTheme.blackColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                width: 5,
                height: 70,
                decoration: BoxDecoration(
                  color: taskModel.isDone
                      ? const Color(0xFF61E757)
                      : AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 16),
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
                        color: taskModel.isDone
                            ? const Color(0xFF61E757)
                            : AppTheme.primaryColor,
                      ),
                    ),
                    Text(
                      taskModel.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
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
              const Spacer(),
              InkWell(
                onTap: () async {
                  taskModel.isDone = true;
                  await FirebaseFunctions.updateTask(taskModel);
                },
                child: taskModel.isDone
                    ? Text(
                        local.done,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: const Color(0xFF61E757),
                        ),
                      )
                    : Container(
                        height: 35,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

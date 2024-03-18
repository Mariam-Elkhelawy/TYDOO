import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:todo_app/features/login/login_screen.dart';
import 'package:todo_app/features/tasks/task_item.dart';
import 'package:todo_app/features/models/task_model.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});
  static const String routeName = 'TaskScreen';

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              color: AppTheme.primaryColor,
              width: mediaQuery.width,
              height: mediaQuery.height * .24,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(45, 0, 20, 0),
                child: Row(
                  children: [
                    Text(
                      local.todoList,
                      style: theme.textTheme.titleLarge,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        await FirebaseFunctions.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.routeName,
                          (route) => false,
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            local.logout,
                            style: theme.textTheme.titleLarge
                                ?.copyWith(fontSize: 14),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.logout,
                            color: provider.themeMode == ThemeMode.dark
                                ? const Color(0xFF060E1E)
                                : Colors.white,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 165, 0, 30),
              child: EasyInfiniteDateTimeLine(
                locale: provider.languageCode == 'ar' ? 'ar' : 'en',
                timeLineProps: const EasyTimeLineProps(separatorPadding: 24),
                showTimelineHeader: false,
                dayProps: EasyDayProps(
                  todayStyle: DayStyle(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: provider.themeMode == ThemeMode.dark
                          ? AppTheme.blackColor
                          : Colors.white,
                    ),
                    dayNumStyle: theme.textTheme.bodyMedium,
                    monthStrStyle: theme.textTheme.bodyMedium,
                    dayStrStyle: theme.textTheme.bodyMedium,
                  ),
                  inactiveDayStyle: DayStyle(
                    dayNumStyle: theme.textTheme.bodyMedium,
                    monthStrStyle: theme.textTheme.bodyMedium,
                    dayStrStyle: theme.textTheme.bodyMedium,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: provider.themeMode == ThemeMode.dark
                          ? AppTheme.blackColor
                          : Colors.white,
                    ),
                  ),
                  activeDayStyle: DayStyle(
                    dayNumStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.primaryColor),
                    monthStrStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppTheme.primaryColor),
                    dayStrStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppTheme.primaryColor),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: provider.themeMode == ThemeMode.dark
                          ? AppTheme.blackColor
                          : Colors.white,
                    ),
                  ),
                  height: 85,
                ),
                firstDate: DateTime.now(),
                focusDate: focusDate,
                lastDate: DateTime(2025),
                onDateChange: (selectedDate) {
                  setState(() {
                    focusDate = selectedDate;
                  });
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseFunctions.getTask(focusDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(local.isError),
                );
              }
              var tasks =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              if (tasks.isEmpty) {
                return Center(
                  child: Text(local.noTasks,style: TextStyle(fontSize: 18),),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: tasks[index],
                  );
                },
                itemCount: tasks.length,
                padding: EdgeInsets.zero,
              );
            },
          ),
        )
      ],
    );
  }
}

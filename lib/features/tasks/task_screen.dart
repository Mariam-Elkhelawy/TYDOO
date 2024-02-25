import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_theme.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:todo_app/features/tasks/task_item.dart';
import 'package:todo_app/providers/my_provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

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
                padding: const EdgeInsetsDirectional.fromSTEB(45, 85, 0, 0),
                child: Text(
                  'To Do List',
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 165, 0, 30),
              child: EasyInfiniteDateTimeLine(
                timeLineProps: EasyTimeLineProps(separatorPadding: 24),
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
                    dayNumStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor),
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
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
            ],
          ),
        )
      ],
    );
  }
}

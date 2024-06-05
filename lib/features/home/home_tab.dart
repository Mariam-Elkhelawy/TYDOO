import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/features/models/task_model.dart';
import 'package:todo_app/features/tasks/task_item.dart';
import 'package:todo_app/firebase/firebase_functions.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DateTime focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var local = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset(
              'assets/images/home_headline.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Positioned(
              top: 110.h,
              left: 24.w,
              child: Text(
                'Hello,',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            Positioned(
              top: 132.h,
              left: 24.w,
              child: Text(
                'Lara Alaa 👋🏻',
                style: theme.textTheme.bodyLarge,
              ),
            ),
            Positioned(
              top: 175.h,
              left: 24.w,
              child: Text(
                'You have 3 tasks for today',
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          disabledDates: List.generate(
            DateTime.now().difference(DateTime(2023)).inDays,
            (index) => DateTime.now().subtract(Duration(days: index + 1)),
          ),
          onDateChange: (selectedDate) {
            setState(() {
              focusDate = selectedDate;
            });
          },
          dayProps: EasyDayProps(
            // dayStructure: DayStructure.dayStrDayNum,
            height: 88.h,
            width: 62.w, inactiveDayStyle: DayStyle(),
            activeDayStyle: const DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsetsDirectional.fromSTEB(24.w, 22.h, 0, 30.h),
        //   child: EasyInfiniteDateTimeLine(
        //     locale: provider.languageCode == 'ar' ? 'ar' : 'en',
        //     // timeLineProps: const EasyTimeLineProps(separatorPadding: 24),
        //     activeColor: AppTheme.primaryColor,
        //     dayProps: EasyDayProps(
        //       // dayStructure: DayStructure.dayStrDayNum,
        //       height: 88.h,
        //       width: 62.w,
        //       todayStyle: DayStyle(
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(8),
        //           color: provider.themeMode == ThemeMode.dark
        //               ? AppTheme.blackColor
        //               : Colors.white,
        //         ),
        //         // dayNumStyle: theme.textTheme.bodyMedium,
        //         // monthStrStyle: theme.textTheme.bodyMedium,
        //         // dayStrStyle: theme.textTheme.bodyMedium,
        //       ),
        //       // inactiveDayStyle: DayStyle(
        //       //   dayNumStyle: theme.textTheme.bodyMedium,
        //       //   monthStrStyle: theme.textTheme.bodyMedium,
        //       //   dayStrStyle: theme.textTheme.bodyMedium,
        //       //   decoration: BoxDecoration(
        //       //     borderRadius: BorderRadius.circular(8),
        //       //     color: provider.themeMode == ThemeMode.dark
        //       //         ? AppTheme.blackColor
        //       //         : Color(0xFFEDEDED),
        //       //   ),
        //       // ),
        //       // activeDayStyle: DayStyle(
        //       //   dayNumStyle: theme.textTheme.bodyMedium
        //       //       ?.copyWith(color: theme.primaryColor),
        //       //   monthStrStyle: theme.textTheme.bodyMedium
        //       //       ?.copyWith(color: AppTheme.primaryColor),
        //       //   dayStrStyle: theme.textTheme.bodyMedium
        //       //       ?.copyWith(color: AppTheme.primaryColor),
        //       //   decoration: BoxDecoration(
        //       //     borderRadius: BorderRadius.circular(8),
        //       //     color: provider.themeMode == ThemeMode.dark
        //       //         ? AppTheme.blackColor
        //       //         : Colors.white,
        //       //   ),
        //       // ),
        //     ),
        //     firstDate: DateTime.now(),
        //     focusDate: focusDate,
        //     lastDate: DateTime(2025),
        //     onDateChange: (selectedDate) {
        //       setState(() {
        //         focusDate = selectedDate;
        //       });
        //     },
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            DateFormat('d MMMM').format(DateUtils.dateOnly(focusDate)),
            style: TextStyle(color: Colors.black),
          ),
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
                  child: Text(
                    local.noTasks,
                    style: const TextStyle(fontSize: 18),
                  ),
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

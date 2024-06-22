import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/app_strings.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/home/task_item.dart';
import 'package:todo_app/features/models/task_model.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DateTime focusDate = DateTime.now();

  Stream<QuerySnapshot<TaskModel>> _getTasksStream() {
    return FirebaseFunctions.getTask(focusDate);
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var provider = Provider.of<MyProvider>(context);

    return StreamBuilder<QuerySnapshot<TaskModel>>(
      stream: _getTasksStream(),
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
        var tasks = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
        return Padding(
          padding: EdgeInsets.only(bottom: 90.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      AppImages.homeHeadline,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 110.h,
                      left: 24.w,
                      child: Text(
                        AppStrings.hello,
                        style: AppStyles.regularText.copyWith(
                            color: AppColor.helloColor, fontSize: 20.sp),
                      ),
                    ),
                    Positioned(
                      top: 135.h,
                      left: 24.w,
                      child: Text(
                        'Lara Alaa 👋🏻',
                        style: AppStyles.titleL,
                      ),
                    ),
                    Positioned(
                      top: 180.h,
                      left: 24.w,
                      child: Text(
                        'You have ${tasks.length} task(s) for today',
                        style: AppStyles.regularText.copyWith(
                            fontSize: 14.sp, color: AppColor.whiteColor),
                      ),
                    ),
                  ],
                ),
                EasyDateTimeLine(
                  initialDate: focusDate,
                  disabledDates: List.generate(
                    DateTime.now().difference(DateTime(2023)).inDays,
                    (index) =>
                        DateTime.now().subtract(Duration(days: index + 1)),
                  ),
                  onDateChange: (selectedDate) {
                    setState(() {
                      focusDate = selectedDate;
                    });
                  },
                  dayProps: EasyDayProps(
                    todayStyle: DayStyle(
                      dayNumStyle: AppStyles.bodyS.copyWith(
                          color: AppColor.thirdColor, fontSize: 14.sp),
                      dayStrStyle: AppStyles.bodyS.copyWith(
                          color: AppColor.inactiveDayColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: AppColor.inactiveColor,
                      ),
                    ),
                    height: 88.h,
                    width: 62.w,
                    dayStructure: DayStructure.dayStrDayNum,
                    inactiveDayStyle: DayStyle(
                      dayNumStyle: AppStyles.bodyS.copyWith(
                          color: AppColor.thirdColor, fontSize: 14.sp),
                      dayStrStyle: AppStyles.bodyS.copyWith(
                          color: AppColor.inactiveDayColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: AppColor.inactiveColor,
                      ),
                    ),
                    activeDayStyle: DayStyle(
                      dayNumStyle: AppStyles.bodyS,
                      dayStrStyle: AppStyles.bodyS.copyWith(
                          color: AppColor.activeDayColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, top: 24.h, bottom: 18.h),
                  child: Text(
                      '${DateFormat('d MMM').format(DateUtils.dateOnly(focusDate))} Tasks',
                      style: AppStyles.bodyL),
                ),
                tasks.isEmpty
                    ? Center(
                        child: Text(
                          local.noTasks,
                          style: const TextStyle(
                              fontSize: 18, color: AppColor.blackColor),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TaskItem(
                            taskModel: tasks[index],
                          );
                        },
                        itemCount: tasks.length,
                        padding: EdgeInsets.zero,
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}

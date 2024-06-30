import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/utils/app_colors.dart';

class EditProvider extends ChangeNotifier {
  DateTime chosenDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          height: 250.h,
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 195.h,
                child: CupertinoDatePicker(
                  backgroundColor: Colors.white,
                  initialDateTime: selectedDate,
                  onDateTimeChanged: (DateTime newDate) {
                    chosenDate = newDate;
                  },
                  use24hFormat: true,
                  minimumDate: selectedDate,
                  maximumDate: DateTime(2025),
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
              CupertinoButton(
                child: const Text('Done', style: TextStyle(color: AppColor.primaryColor)),
                onPressed: () {
                  notifyListeners();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectStartTime(BuildContext context) async {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            height: 250.h,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 195.h,
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.white,
                    initialDateTime: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      selectedStartTime.hour,
                      selectedStartTime.minute,
                    ),
                    onDateTimeChanged: (DateTime newDateTime) {
                      selectedStartTime = TimeOfDay(
                        hour: newDateTime.hour,
                        minute: newDateTime.minute,
                      );
                    },
                    mode: CupertinoDatePickerMode.time,
                  ),
                ),
                CupertinoButton(
                  child: const Text('Done', style: TextStyle(color: AppColor.primaryColor)),
                  onPressed: () {
                    notifyListeners();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      );
  }

  Future<void> selectEndTime(BuildContext context) async {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            height: 250.h,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 195.h,
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.white,
                    initialDateTime: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      selectedEndTime.hour,
                      selectedEndTime.minute,
                    ),
                    onDateTimeChanged: (DateTime newDateTime) {
                      selectedEndTime = TimeOfDay(
                        hour: newDateTime.hour,
                        minute: newDateTime.minute,
                      );
                    },
                    use24hFormat: false,
                    mode: CupertinoDatePickerMode.time,
                  ),
                ),
                CupertinoButton(
                  child: const Text('Done', style: TextStyle(color: AppColor.primaryColor)),
                  onPressed: () {
                    notifyListeners();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      );
  }
}

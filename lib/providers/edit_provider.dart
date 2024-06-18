import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/providers/my_provider.dart';

class EditProvider extends ChangeNotifier {
  DateTime chosenDate = DateTime.now();

  void selectDate(BuildContext context) async {
    var provider = Provider.of<MyProvider>(context, listen: false);

    DateTime? selectedDate = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              backgroundColor: AppColor.whiteColor,
              dayForegroundColor: const MaterialStatePropertyAll(AppColor.thirdColor),
              dividerColor: AppColor.primaryColor,
              dayBackgroundColor: const MaterialStatePropertyAll(AppColor.blackColor),
              dayStyle: AppStyles.bodyS,
              headerHeadlineStyle: AppStyles.bodyS,
              rangePickerHeaderHeadlineStyle: AppStyles.bodyS,
              weekdayStyle: AppStyles.generalText,
              headerHelpStyle: AppStyles.bodyS,
            ),
          ),
          child: child!,
        );
      },
      textDirection: provider.languageCode == 'en' ? TextDirection.ltr : TextDirection.rtl,
      locale: Locale(provider.languageCode == 'en' ? 'en' : 'ar'),
      initialDate: chosenDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (selectedDate != null) {
      chosenDate = selectedDate;
      notifyListeners();
    }
  }

  // void showDatePickerModal(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: 200.h,
  //         padding: const EdgeInsets.all(16.0),
  //         child: Row(
  //           children: [
  //             ElevatedButton(
  //               onPressed: () => selectDate(context),
  //               child: const Text('Select Date'),
  //             ),
  //             Text(
  //               "Selected Date: ${chosenDate.toLocal()}".split(' ')[0],
  //               style: AppStyles.bodyS,
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}

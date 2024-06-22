import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/category/add_category_screen.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});
  static const String routeName = 'TaskScreen';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;

    return Column(
      children: [
        SizedBox(height: 75.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ImageIcon(
                AssetImage('assets/images/ic_search.png'),
                color: AppColor.taskGreyColor,
              ),
              Text(
                'Category',
                style: AppStyles.titleL.copyWith(color: AppColor.blackColor),
              ),
              const ImageIcon(
                AssetImage('assets/images/ic_sort.png'),
                color: AppColor.taskGreyColor,
              ),
            ],
          ),
        ),
        SizedBox(height: 75.h),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddCategoryScreen.routeName);
            },
            child: Text('Add'))
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/category/add_category_screen.dart';
import 'package:todo_app/features/category/category_item.dart';
import 'package:todo_app/features/data/models/category_model.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});
  static const String routeName = 'TaskScreen';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 75.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: SvgPicture.asset(
                    AppImages.addCategoryIcon,
                    colorFilter: ColorFilter.mode(
                        provider.themeMode == ThemeMode.light
                            ? AppColor.taskGreyColor
                            : AppColor.whiteColor,
                        BlendMode.srcIn),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, AddCategoryScreen.routeName);
                  },
                ),
                Text(
                  local.category,
                  style: AppStyles.bodyL.copyWith(
                      color: provider.themeMode == ThemeMode.light
                          ? AppColor.primaryColor
                          : AppColor.primaryDarkColor),
                ),
                ImageIcon(
                  const AssetImage(AppImages.sort),
                  color: provider.themeMode == ThemeMode.light
                      ? AppColor.taskGreyColor
                      : AppColor.whiteColor,
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          StreamBuilder<QuerySnapshot<CategoryModel>>(
            stream: FirebaseFunctions.getCategory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 600.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: provider.themeMode == ThemeMode.light
                          ? AppColor.primaryColor
                          : AppColor.primaryDarkColor,
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    local.error,
                    style: AppStyles.titleL.copyWith(
                        fontSize: 14.sp,
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.primaryColor
                            : AppColor.primaryDarkColor),
                  ),
                );
              }
              var categories =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

              return categories.isEmpty
                  ? Column(
                      children: [
                        SizedBox(height: 112.h),
                        Image.asset(
                          AppImages.empty,
                          width: 239.w,
                          height: 239.h,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          local.noCategory,
                          style: AppStyles.titleL.copyWith(
                              fontSize: 14.sp,
                              color: provider.themeMode == ThemeMode.light
                                  ? AppColor.primaryColor
                                  : AppColor.primaryDarkColor),
                        )
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CategoryItem(
                          categoryModel: categories[index],
                        );
                      },
                      itemCount: categories.length,
                      padding: EdgeInsets.zero,
                    );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/category/add_category_screen.dart';
import 'package:todo_app/features/category/category_item.dart';
import 'package:todo_app/features/data/models/category_model.dart';
import 'package:todo_app/features/home/task_item.dart';
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

    return Column(
      children: [
        SizedBox(height: 75.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ImageIcon(
                AssetImage(AppImages.search),
                color: AppColor.taskGreyColor,
              ),
              Text(
                'Category',
                style: AppStyles.bodyL.copyWith(color: AppColor.primaryColor),
              ),
              const ImageIcon(
                AssetImage(AppImages.sort),
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
            child: const Text('Add')),
        StreamBuilder<QuerySnapshot<CategoryModel>>(
          stream: FirebaseFunctions.getCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(local.isError),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text('No Categories'),
              );
            }
            var categories =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            return ListView.builder(
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
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/category/add_category_screen.dart';
import 'package:todo_app/features/data/models/category_model.dart';
import 'package:todo_app/features/home/edit_tasks_screen.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/widgets/custom_dialog.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryModel});
final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: AppColor.blackColor.withOpacity(.11),
              spreadRadius: 0,
              offset: const Offset(0, 0),
              blurRadius: 16)
        ],
        color: Colors.transparent,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .3,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                topLeft: Radius.circular(15.r),
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
                          await FirebaseFunctions.deleteCategory(categoryModel.id);
                        },
                        dialogContent: local.deleteAlert,
                        dialogTitle: local.alert);
                  },
                );
              },
              backgroundColor: AppColor.deleteColor,
              icon: Icons.delete,
              label: local.delete,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: provider.themeMode == ThemeMode.light
                ? AppColor.whiteColor
                : AppColor.blackColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                width: 8.w,
                height: 83.h,
                decoration: BoxDecoration(
                  color: categoryModel.categoryColor,
                  borderRadius: BorderRadius.only(
                      topLeft:provider.languageCode=='en'? Radius.circular(12.r):Radius.circular(0.r),
                      bottomLeft:provider.languageCode=='en'? Radius.circular(12.r):Radius.circular(0.r),
                      bottomRight:provider.languageCode=='en'? Radius.circular(0.r):Radius.circular(12.r),
                      topRight:provider.languageCode=='en'? Radius.circular(0.r):Radius.circular(12.r),
                      ),
                ),
              ),
              SizedBox(width: 9.w),
              Container(
                width: 85.w,height: 60.h,
                decoration: BoxDecoration(
                  color:const Color(0xFFD9D9D9),borderRadius: BorderRadius.circular(12.r)
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      categoryModel.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.titleL.copyWith(
                          fontSize: 14.sp, color: AppColor.primaryColor),
                    ),
                    Text(
                      categoryModel.note,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                       style: AppStyles.generalText.copyWith(
                    fontSize: 12.sp, color: AppColor.taskGreyColor,
                    ),),
                    SizedBox(height: 8.h),

                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    EditTaskScreen.routeName,
                    arguments: CategoryModel(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      id: categoryModel.id,
                      name: categoryModel.name,
                      note: categoryModel.note,
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 18.w),
                  child: const ImageIcon(
                    AssetImage(
                      'assets/images/Edit.png',
                    ),
                    color: AppColor.taskGreyColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

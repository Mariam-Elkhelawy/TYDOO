import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/components/reusable_components.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/models/task_model.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/edit_provider.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_dialog.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});
  static const String routeName = 'AddTask';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.addTaskBG), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const ImageIcon(
                AssetImage(AppImages.arrow),
                size: 20,
                color: AppColor.iconColor,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Add Task',
            style: AppStyles.bodyL.copyWith(color: AppColor.primaryColor),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: const Icon(
                Icons.notifications,
                color: AppColor.iconColor,
              ),
            )
          ],
        ),
        body: ChangeNotifierProvider(
          create: (context) => EditProvider(),
          builder: (context, child) {
            var editProvider = Provider.of<EditProvider>(context);

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16.h),
                      Image.asset(
                        AppImages.addTask,
                        width: 187.w,
                        height: 187.h,
                      ),
                      Text(
                        local.addTask,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        myController: titleController,
                        hintText: local.enterTitle,
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return local.validateTitle;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 11.h),
                      customTextFormField(
                        borderColor: AppColor.borderColor,
                        cursorColor: AppColor.primaryColor,
                        radius: 8.r,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        hintStyle: AppStyles.hintText,
                        fillColor: Colors.transparent,
                        controller: titleController,
                        hintText: local.enterTitle,
                        textStyle:
                            AppStyles.generalText.copyWith(fontSize: 15.sp),
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return local.validateTitle;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hintText: local.enterDescription,
                        myController: descriptionController,
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return local.validateDescription;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        local.selectDate,
                        style: AppStyles.titleL.copyWith(
                            color: AppColor.blackColor, fontSize: 13.sp),
                      ),
                      SizedBox(height: 7.h),
                      InkWell(
                        onTap: () {
                          editProvider.selectDate(context);
                        },
                        child: Container(
                          padding: EdgeInsetsDirectional.only(
                              start: 16.w, top: 10.h, bottom: 10.h, end: 13.w),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.borderColor),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Row(
                            children: [
                              Text(
                                DateFormat.yMMMd(provider.languageCode == 'en'
                                        ? 'en'
                                        : 'ar')
                                    .format(editProvider.chosenDate),
                                style: AppStyles.generalText,
                              ),
                              const Spacer(),
                              const ImageIcon(AssetImage(AppImages.calendar))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 11.h),

                      Text(
                        'Color',
                        style: AppStyles.titleL.copyWith(
                            color: AppColor.blackColor, fontSize: 13.sp),
                      ),
                      SizedBox(height: 7.h),

                      SizedBox(height: 20.h),

                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            TaskModel taskModel = TaskModel(
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                id: '',
                                title: titleController.text,
                                taskColor: Colors.blue,
                                date:
                                    DateUtils.dateOnly(editProvider.chosenDate),
                                description: descriptionController.text);
                            await FirebaseFunctions.addTask(taskModel);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  dialogContent: local.addTaskSuccess,
                                  dialogTitle: local.success,
                                  actionRequired: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          }
                        },
                        child: customButton(
                            borderColor: AppColor.primaryColor,
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(12.r),
                            height: 46.h,
                            child: Text(
                              local.addTaskButton,
                              style: AppStyles.bodyL.copyWith(
                                  color: AppColor.whiteColor, fontSize: 16.sp),
                            )),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

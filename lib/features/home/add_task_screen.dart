import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/components/reusable_components.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/app_strings.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/data/models/task_model.dart';
import 'package:todo_app/features/home/text_widget.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/edit_provider.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_dialog.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  static const String routeName = 'AddTask';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int color = 0;
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
          elevation: 0,
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
                      const TextWidget(text: 'Title'),
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
                      const TextWidget(text: 'Description'),
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
                      const TextWidget(text: 'Date'),
                      InkWell(
                        onTap: () {
                          editProvider.selectDate(context);
                        },
                        child: customButton(
                          borderColor: AppColor.borderColor,
                          borderRadius: BorderRadius.circular(8.r),
                          padding: EdgeInsetsDirectional.only(
                              start: 16.w, top: 10.h, bottom: 10.h, end: 13.w),
                          child: Row(
                            children: [
                              Text(
                                DateFormat.yMMMd(provider.languageCode == 'en'
                                        ? 'en'
                                        : 'ar')
                                    .format(editProvider.chosenDate),
                                style: AppStyles.generalText
                                    .copyWith(fontSize: 12.sp),
                              ),
                              const Spacer(),
                              const ImageIcon(
                                AssetImage(AppImages.calendar),
                                color: AppColor.primaryColor,
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(text: 'Start Time'),
                                InkWell(
                                  onTap: () {},
                                  child: customButton(
                                    borderColor: AppColor.borderColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                    padding: EdgeInsetsDirectional.only(
                                        start: 16.w,
                                        top: 9.h,
                                        bottom: 9.h,
                                        end: 8.w),
                                    child: Row(
                                      children: [
                                        Text(
                                          startTime,
                                          style: AppStyles.generalText
                                              .copyWith(fontSize: 12.sp),
                                        ),
                                        const Spacer(),
                                        const ImageIcon(
                                          AssetImage(AppImages.clock),
                                          color: AppColor.primaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(text: 'End Time'),
                                InkWell(
                                  onTap: () {},
                                  child: customButton(
                                    borderColor: AppColor.borderColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                    padding: EdgeInsetsDirectional.only(
                                        start: 16.w,
                                        top: 9.h,
                                        bottom: 9.h,
                                        end: 8.w),
                                    child: Row(
                                      children: [
                                        Text(
                                          endTime,
                                          style: AppStyles.generalText
                                              .copyWith(fontSize: 12.sp),
                                        ),
                                        const Spacer(),
                                        const ImageIcon(
                                          AssetImage(AppImages.clock),
                                          color: AppColor.primaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const TextWidget(text: 'Remind'),
                      customButton(
                          padding:
                              EdgeInsetsDirectional.only(start: 16.w, end: 9.w),
                          borderRadius: BorderRadius.circular(8.r),
                          borderColor: AppColor.borderColor,
                          child: DropdownButton(
                            hint: Text(
                              AppStrings.remind,
                              style: AppStyles.generalText
                                  .copyWith(fontSize: 12.sp),
                            ),
                            underline: Container(height: 0.h),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(8.r),
                            dropdownColor: AppColor.whiteColor,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColor.primaryColor,
                              size: 28,
                            ),
                            items: AppStrings.remindList
                                .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: AppStyles.generalText
                                          .copyWith(fontSize: 12.sp),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              AppStrings.remind = value!;
                              setState(() {});
                            },
                          )),
                      const TextWidget(text: 'Repeat'),
                      customButton(
                          padding:
                              EdgeInsetsDirectional.only(start: 16.w, end: 9.w),
                          borderRadius: BorderRadius.circular(8.r),
                          borderColor: AppColor.borderColor,
                          child: DropdownButton(
                            hint: Text(
                              AppStrings.repeat,
                              style: AppStyles.generalText
                                  .copyWith(fontSize: 12.sp),
                            ),
                            underline: Container(height: 0.h),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(8.r),
                            dropdownColor: AppColor.whiteColor,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColor.primaryColor,
                              size: 28,
                            ),
                            items: AppStrings.repeatList
                                .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: AppStyles.generalText
                                          .copyWith(fontSize: 12.sp),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              AppStrings.repeat = value!;
                              setState(() {});
                            },
                          )),
                      const TextWidget(text: 'Color'),
                      Wrap(
                        children: List.generate(
                          7,
                          (index) => GestureDetector(
                            onTap: () {
                              color = index;
                              setState(() {});
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(end: 11.w,top: 5.h),
                              child: CircleAvatar(
                                backgroundColor: AppColor.colorPalette[index],
                                radius: 16.r,
                                child: color == index
                                    ? const Icon(
                                        Icons.done,
                                        color: AppColor.whiteColor,
                                        size: 16,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            TaskModel taskModel = TaskModel(
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                id: '',
                                title: titleController.text,
                                taskColor: AppColor.colorPalette[color],startTime: startTime,endTime: endTime,
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
                      SizedBox(height: 22.h),
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

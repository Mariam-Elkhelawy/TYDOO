import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/components/reusable_components.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/data/models/category_model.dart';
import 'package:todo_app/features/data/models/task_model.dart';
import 'package:todo_app/features/home/text_widget.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/edit_provider.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key});
  static const String routeName = 'EditTaskScreen';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TaskModel? model;
  DateTime? chosenDate;
  String? startTime;
  String? endTime;
  bool isTapped = false;
  Color? taskColor;
  String? selectedCategory;
  String? selectedRemind;
  String? selectedRepeat;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (model == null) {
      model = ModalRoute.of(context)!.settings.arguments as TaskModel;
      titleController.text = model!.title;
      descriptionController.text = model!.description;
      chosenDate = model!.date;
      startTime = model!.startTime;
      endTime = model!.endTime;
      taskColor = model!.taskColor;
      selectedCategory = model!.categoryId;
      // selectedRemind = model!.remind;
      // selectedRepeat = model!.repeat;
    }
  }

  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateFormat.jm().parse(startTime!))
          : TimeOfDay.fromDateTime(DateFormat.jm().parse(endTime!)),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked.format(context);
        } else {
          endTime = picked.format(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;
    List<String> remindList = [
      local.min5,
      local.min10,
      local.min15,
      local.min20,
    ];
    List<String> repeatList = [
      local.none,
      local.daily,
      local.weekly,
      local.monthly
    ];

    return ChangeNotifierProvider<EditProvider>(
      create: (context) => EditProvider(),
      builder: (context, child) {
        var editProvider = Provider.of<EditProvider>(context);
        chosenDate = DateUtils.dateOnly(editProvider.chosenDate);
        return customBG(
          context: context,
          child: Scaffold(
            backgroundColor: provider.themeMode == ThemeMode.light
                ? Colors.transparent
                : AppColor.darkColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: provider.themeMode == ThemeMode.light
                  ? Colors.transparent
                  : AppColor.darkColor,
              leading: Padding(
                padding: EdgeInsetsDirectional.only(start: 24.w),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ImageIcon(
                    AssetImage(provider.languageCode == 'en'
                        ? AppImages.arrow
                        : AppImages.arrowAR),
                    size: 20,
                    color: provider.themeMode == ThemeMode.light
                        ? AppColor.iconColor
                        : AppColor.whiteColor,
                  ),
                ),
              ),
              centerTitle: true,
              title: Text(
                local.editTask,
                style: AppStyles.bodyL.copyWith(
                    color: provider.themeMode == ThemeMode.light
                        ? AppColor.primaryColor
                        : AppColor.primaryDarkColor),
              ),
              actions: [
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 24.w),
                  child: Icon(
                    Icons.notifications,
                    color: provider.themeMode == ThemeMode.light
                        ? AppColor.iconColor
                        : AppColor.whiteColor,
                  ),
                )
              ],
            ),
            body: Padding(
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
                      TextWidget(text: local.title),
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
                      TextWidget(text: local.description),
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
                      TextWidget(text: local.category),
                      customButton(
                          padding:
                              EdgeInsetsDirectional.only(start: 16.w, end: 9.w),
                          borderRadius: BorderRadius.circular(8.r),
                          borderColor: AppColor.borderColor,
                          child: DropdownButton(
                            hint: Text(
                                provider.categories.isEmpty
                                    ? local.noCat
                                    : local.select,
                                style: AppStyles.hintText.copyWith(
                                  color: provider.themeMode == ThemeMode.light
                                      ? AppColor.blackColor.withOpacity(.5)
                                      : AppColor.whiteColor.withOpacity(.5),
                                )),
                            underline: Container(height: 0.h),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(8.r),
                            dropdownColor: AppColor.whiteColor,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: provider.themeMode == ThemeMode.light
                                  ? AppColor.primaryColor
                                  : AppColor.primaryDarkColor,
                              size: 28,
                            ),
                            value: selectedCategory,
                            items: provider.categories
                                .map<DropdownMenuItem<String>>(
                                    (CategoryModel category) {
                              return DropdownMenuItem<String>(
                                value: category.id,
                                child: Text(
                                  category.name,
                                  style: AppStyles.generalText.copyWith(
                                    fontSize: 12.sp,
                                    color: provider.themeMode == ThemeMode.light
                                        ? AppColor.primaryColor
                                        : AppColor.primaryDarkColor,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue;
                              });
                            },
                          )),
                      TextWidget(text: local.date),
                      InkWell(
                        onTap: () {
                          editProvider.selectDate(context);
                          setState(() {});
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
                                    .format(chosenDate!),
                                style: AppStyles.generalText.copyWith(
                                  fontSize: 12.sp,
                                  color: provider.themeMode == ThemeMode.light
                                      ? AppColor.primaryColor
                                      : AppColor.primaryDarkColor,
                                ),
                              ),
                              const Spacer(),
                              ImageIcon(
                                const AssetImage(AppImages.calendar),
                                color: provider.themeMode == ThemeMode.light
                                    ? AppColor.primaryColor
                                    : AppColor.primaryDarkColor,
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
                                TextWidget(text: local.startTime),
                                InkWell(
                                  onTap: () => selectTime(context, true),
                                  child: customButton(
                                    borderColor: AppColor.borderColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                    padding: EdgeInsetsDirectional.only(
                                        start: 16.w,
                                        top: 10.h,
                                        bottom: 10.h,
                                        end: 13.w),
                                    child: Row(
                                      children: [
                                        Text(
                                          startTime!,
                                          style: AppStyles.generalText.copyWith(
                                            fontSize: 12.sp,
                                            color: provider.themeMode ==
                                                    ThemeMode.light
                                                ? AppColor.primaryColor
                                                : AppColor.primaryDarkColor,
                                          ),
                                        ),
                                        const Spacer(),
                                        ImageIcon(
                                          const AssetImage(AppImages.clock),
                                          color: provider.themeMode ==
                                                  ThemeMode.light
                                              ? AppColor.primaryColor
                                              : AppColor.primaryDarkColor,
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
                                TextWidget(text: local.endTime),
                                InkWell(
                                  onTap: () => selectTime(context, false),
                                  child: customButton(
                                    borderColor: AppColor.borderColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                    padding: EdgeInsetsDirectional.only(
                                        start: 16.w,
                                        top: 10.h,
                                        bottom: 10.h,
                                        end: 13.w),
                                    child: Row(
                                      children: [
                                        Text(
                                          endTime!,
                                          style: AppStyles.generalText.copyWith(
                                            fontSize: 12.sp,
                                            color: provider.themeMode ==
                                                    ThemeMode.light
                                                ? AppColor.primaryColor
                                                : AppColor.primaryDarkColor,
                                          ),
                                        ),
                                        const Spacer(),
                                        ImageIcon(
                                          const AssetImage(AppImages.clock),
                                          color: provider.themeMode ==
                                                  ThemeMode.light
                                              ? AppColor.primaryColor
                                              : AppColor.primaryDarkColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      TextWidget(text: local.remind),
                      customButton(
                          padding:
                              EdgeInsetsDirectional.only(start: 16.w, end: 9.w),
                          borderRadius: BorderRadius.circular(8.r),
                          borderColor: AppColor.borderColor,
                          child: DropdownButton(
                            hint: Text(
                              local.select,
                              style: AppStyles.hintText.copyWith(
                                color: provider.themeMode == ThemeMode.light
                                    ? AppColor.blackColor.withOpacity(.5)
                                    : AppColor.whiteColor.withOpacity(.5),
                              ),
                            ),
                            underline: Container(height: 0.h),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(8.r),
                            dropdownColor: AppColor.whiteColor,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: provider.themeMode == ThemeMode.light
                                  ? AppColor.primaryColor
                                  : AppColor.primaryDarkColor,
                              size: 28,
                            ),
                            value: selectedRemind,
                            items: remindList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: AppStyles.generalText.copyWith(
                                    fontSize: 12.sp,
                                    color: provider.themeMode == ThemeMode.light
                                        ? AppColor.primaryColor
                                        : AppColor.primaryDarkColor,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedRemind = newValue;
                              });
                            },
                          )),
                      TextWidget(text: local.repeat),
                      customButton(
                        padding:
                            EdgeInsetsDirectional.only(start: 16.w, end: 9.w),
                        borderRadius: BorderRadius.circular(8.r),
                        borderColor: AppColor.borderColor,
                        child: DropdownButton(
                          hint: Text(
                            local.select,
                            style: AppStyles.hintText.copyWith(
                              color: provider.themeMode == ThemeMode.light
                                  ? AppColor.blackColor.withOpacity(.5)
                                  : AppColor.whiteColor.withOpacity(.5),
                            ),
                          ),
                          underline: Container(height: 0.h),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(8.r),
                          dropdownColor: AppColor.whiteColor,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: provider.themeMode == ThemeMode.light
                                ? AppColor.primaryColor
                                : AppColor.primaryDarkColor,
                            size: 28,
                          ),
                          value: selectedRepeat,
                          items: repeatList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: AppStyles.generalText.copyWith(
                                  fontSize: 12.sp,
                                  color: provider.themeMode == ThemeMode.light
                                      ? AppColor.primaryColor
                                      : AppColor.primaryDarkColor,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(
                              () {
                                selectedRepeat = newValue;
                              },
                            );
                          },
                        ),
                      ),
                      TextWidget(text: local.color),
                      Wrap(
                        children: List.generate(
                          7,
                          (index) => GestureDetector(
                            onTap: () {
                              taskColor = AppColor.colorPalette[index];
                              setState(() {});
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  end: 11.w, top: 5.h),
                              child: CircleAvatar(
                                backgroundColor: AppColor.colorPalette[index],
                                radius: 16.r,
                                child: taskColor == AppColor.colorPalette[index]
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
                      SizedBox(height: 16.h),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            FirebaseFunctions.updateTask(
                              TaskModel(
                                id: model!.id,
                                title: titleController.text,
                                description: descriptionController.text,
                                date: chosenDate!,
                                startTime: startTime!,
                                endTime: endTime!,
                                taskColor: taskColor!,
                                categoryId: selectedCategory!,
                                //  selectedRemind!,
                                // repeat: selectedRepeat!,
                                userId: FirebaseAuth.instance.currentUser!.uid,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: customButton(
                          borderColor: provider.themeMode == ThemeMode.light
                              ? AppColor.primaryColor
                              : AppColor.primaryDarkColor,
                          color: provider.themeMode == ThemeMode.light
                              ? AppColor.primaryColor
                              : AppColor.primaryDarkColor,
                          borderRadius: BorderRadius.circular(12.r),
                          height: 46.h,
                          child: Text(
                            local.saveEdit,
                            style: AppStyles.bodyL.copyWith(
                                color: AppColor.whiteColor, fontSize: 16.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 22.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


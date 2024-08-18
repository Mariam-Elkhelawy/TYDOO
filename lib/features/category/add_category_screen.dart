import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/components/reusable_components.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/app_strings.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/data/models/category_model.dart';
import 'package:todo_app/features/home/text_widget.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_dialog.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});
  static const String routeName = 'AddCategory';

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  int color = 0;
  File? image;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context, listen: false);
    var local = AppLocalizations.of(context)!;

    getImageFromGallery() async {
      final ImagePicker picker = ImagePicker();
      final XFile? imageGallery =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageGallery != null) {
        image = File(imageGallery.path);
        provider.setImagePath(imageGallery.path);
      }
      setState(() {});
    }

    return customBG(
      context: context,
      child: Scaffold(
        backgroundColor:provider.themeMode == ThemeMode.light
            ?  Colors.transparent:AppColor.darkColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor:provider.themeMode == ThemeMode.light
              ?  Colors.transparent:AppColor.darkColor,
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
                color:provider.themeMode == ThemeMode.light
                    ?  AppColor.iconColor:AppColor.whiteColor,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            local.addCategory,
            style: AppStyles.bodyL.copyWith(color: provider.themeMode == ThemeMode.light
                ? AppColor.primaryColor:AppColor.primaryDarkColor),
          ),
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
                    AppImages.addCategory,
                    width: 268.w,
                    height: 268.h,
                  ),
                  TextWidget(text: local.name),
                  CustomTextFormField(
                    myController: nameController,
                    hintText: local.enterTitle,
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return local.validateTitle;
                      }
                      return null;
                    },
                  ),
                  TextWidget(text: local.note),
                  CustomTextFormField(
                    hintText: local.enterDescription,
                    myController: noteController,
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return local.validateDescription;
                      }
                      return null;
                    },
                  ),
                  TextWidget(text: local.color),
                  Wrap(
                    children: List.generate(
                      7,
                      (index) => GestureDetector(
                        onTap: () {
                          color = index;
                          setState(() {});
                        },
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.only(end: 11.w, top: 5.h),
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
                  SizedBox(height: 34.h),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: local.addImage,
                          style: AppStyles.titleL.copyWith(
                              color:     provider.themeMode==ThemeMode.light?
                               AppColor.blackColor:AppColor.whiteColor, fontSize: 13.sp),
                        ),
                        TextSpan(
                          text: local.optional,
                          style: AppStyles.titleL.copyWith(
                              color:  provider.themeMode==ThemeMode.light?
                              AppColor.optionalColor:AppColor.taskGreyColor, fontSize: 12.sp),
                        ),
                        TextSpan(
                          text: local.parentheses,
                          style: AppStyles.titleL.copyWith(
                              color:   provider.themeMode==ThemeMode.light?
                              AppColor.blackColor:AppColor.whiteColor, fontSize: 13.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  InkWell(
                    onTap: getImageFromGallery,
                    child: Row(
                      children: [
                        provider.imagePath == null
                            ? Image.asset(AppImages.addImage)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.file(
                                  File(provider.imagePath!),
                                  width: 24.w,
                                  height: 24.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        SizedBox(width: 7.w),
                        Text(
                          local.click,
                          style: AppStyles.hintText.copyWith(
                            color:      provider.themeMode==ThemeMode.light?
                            AppColor.blackColor.withOpacity(.5):AppColor.whiteColor.withOpacity(.5),
                            decoration: TextDecoration.underline,
                            decorationColor:
                            provider.themeMode==ThemeMode.light?
                                AppColor.blackColor.withOpacity(.5):AppColor.whiteColor.withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 36.h),
                  InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        CategoryModel categoryModel = CategoryModel(
                          id: '',
                          name: nameController.text,
                          note: noteController.text,
                          imagePath: provider.imagePath,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          categoryColor: AppColor.colorPalette[color],
                        );

                        await FirebaseFunctions.addCategory(categoryModel);
                        provider.setImagePath(null);
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
                      color: provider.themeMode==ThemeMode.light?AppColor.primaryColor:AppColor.primaryDarkColor,
                      borderRadius: BorderRadius.circular(12.r),
                      height: 46.h,
                      child: Text(
                        local.addTask,
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
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/components/reusable_components.dart';
import 'package:todo_app/core/components/signwith_widget.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPassword = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;

    return customBG(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            local.create,
            style: AppStyles.titleL.copyWith(
                color: provider.themeMode == ThemeMode.light
                    ? AppColor.blackColor
                    : AppColor.whiteColor),
          ),
          backgroundColor: Colors.transparent,
          toolbarHeight: 140.h,
          leading: Padding(
            padding: EdgeInsetsDirectional.only(start: 24.w),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: ImageIcon(
                const AssetImage(AppImages.arrow),
                size: 20,
                color: provider.themeMode == ThemeMode.light
                    ? AppColor.iconColor
                    : AppColor.whiteColor,
              ),
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    local.fullName,
                    style: AppStyles.regularText.copyWith(
                        fontSize: 15.sp,
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.blackColor
                            : AppColor.whiteColor),
                  ),
                  SizedBox(height: 6.h),
                  customTextFormField(
                    borderColor: AppColor.borderColor,
                    fillColor: Colors.transparent,         cursorColor: provider.themeMode == ThemeMode.light
                      ? AppColor.primaryColor
                      : AppColor.primaryDarkColor,
                    controller: nameController,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                    radius: 10.r,
                    hintStyle: AppStyles.hintText.copyWith(
                      color: provider.themeMode == ThemeMode.light
                          ? AppColor.blackColor.withOpacity(.5)
                          : AppColor.whiteColor.withOpacity(.5),
                    ),
                    textStyle: AppStyles.generalText.copyWith(
                        fontSize: 15.sp,
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.primaryColor
                            : AppColor.primaryDarkColor),
                    suffixIcon: const Icon(
                      Icons.person,
                      color: AppColor.taskGreyColor,
                    ),
                    hintText: local.nameHint,
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return local.validateName;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    local.email,
                    style: AppStyles.regularText.copyWith(
                        fontSize: 15.sp,
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.blackColor
                            : AppColor.whiteColor),
                  ),
                  SizedBox(height: 6.h),
                  customTextFormField(
                      borderColor: AppColor.borderColor,
                      fillColor: Colors.transparent,
                      controller: emailController,         cursorColor: provider.themeMode == ThemeMode.light
                      ? AppColor.primaryColor
                      : AppColor.primaryDarkColor,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 18.h),
                      radius: 10.r,
                      hintStyle: AppStyles.hintText.copyWith(
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.blackColor.withOpacity(.5)
                            : AppColor.whiteColor.withOpacity(.5),
                      ),
                      textStyle: AppStyles.generalText.copyWith(
                          fontSize: 15.sp,
                          color: provider.themeMode == ThemeMode.light
                              ? AppColor.primaryColor
                              : AppColor.primaryDarkColor),
                      suffixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppColor.taskGreyColor,
                      ),
                      hintText: local.emailHint,
                      keyboardType: TextInputType.emailAddress,
                      onValidate: (value) {
                        if (value!.trim().isEmpty) {
                          return local.validateEmail;
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return local.validateEmail2;
                        }
                        return null;
                      }),
                  SizedBox(height: 30.h),
                  Text(
                    local.phoneNumber,
                    style: AppStyles.regularText.copyWith(
                        fontSize: 15.sp,
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.blackColor
                            : AppColor.whiteColor),
                  ),
                  SizedBox(height: 6.h),
                  customTextFormField(
                    borderColor: AppColor.borderColor,
                    fillColor: Colors.transparent,
                    controller: phoneController,         cursorColor: provider.themeMode == ThemeMode.light
                      ? AppColor.primaryColor
                      : AppColor.primaryDarkColor,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                    radius: 10.r,
                    hintStyle: AppStyles.hintText.copyWith(
                      color: provider.themeMode == ThemeMode.light
                          ? AppColor.blackColor.withOpacity(.5)
                          : AppColor.whiteColor.withOpacity(.5),
                    ),
                    textStyle: AppStyles.generalText.copyWith(
                        fontSize: 15.sp,
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.primaryColor
                            : AppColor.primaryDarkColor),
                    suffixIcon: const Icon(
                      Icons.phone,
                      color: AppColor.taskGreyColor,
                    ),
                    hintText: local.phoneHint,
                    keyboardType: TextInputType.number,
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return local.validatePhone;
                      }
                      RegExp regex = RegExp(r'^(?:[+0]2)?01[0125][0-9]{8}$');
                      if (!regex.hasMatch(value)) {
                        return local.validatePhone2;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    local.password,
                    style: AppStyles.regularText.copyWith(
                        fontSize: 15.sp,
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.blackColor
                            : AppColor.whiteColor),
                  ),
                  SizedBox(height: 6.h),
                  customTextFormField(
                    borderColor: AppColor.borderColor,         cursorColor: provider.themeMode == ThemeMode.light
                      ? AppColor.primaryColor
                      : AppColor.primaryDarkColor,
                    fillColor: Colors.transparent,
                    controller: passwordController,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                    radius: 10.r,
                    hintStyle: AppStyles.hintText.copyWith(
                      color: provider.themeMode == ThemeMode.light
                          ? AppColor.blackColor.withOpacity(.5)
                          : AppColor.whiteColor.withOpacity(.5),
                    ),
                    isPassword: isPassword,
                    textStyle: AppStyles.generalText.copyWith(
                        fontSize: 15.sp,
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.primaryColor
                            : AppColor.primaryDarkColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        !isPassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColor.taskGreyColor,
                      ),
                      onPressed: () {
                        isPassword = !isPassword;
                        setState(() {});
                      },
                    ),
                    hintText: local.passwordHint,
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return local.validatePassword;
                      }
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (!regex.hasMatch(value)) {
                        return local.validatePassword2;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    local.confirmPassword,
                    style: AppStyles.regularText.copyWith(
                        fontSize: 15.sp,
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.blackColor
                            : AppColor.whiteColor),
                  ),
                  SizedBox(height: 6.h),
                  customTextFormField(
                    borderColor: AppColor.borderColor,
                    fillColor: Colors.transparent,
                    controller: confirmPasswordController,         cursorColor: provider.themeMode == ThemeMode.light
                      ? AppColor.primaryColor
                      : AppColor.primaryDarkColor,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                    radius: 10.r,
                    hintStyle: AppStyles.hintText.copyWith(
                      color: provider.themeMode == ThemeMode.light
                          ? AppColor.blackColor.withOpacity(.5)
                          : AppColor.whiteColor.withOpacity(.5),
                    ),
                    isPassword: isPassword,
                    textStyle: AppStyles.generalText.copyWith(
                        fontSize: 15.sp,
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.primaryColor
                            : AppColor.primaryDarkColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        !isPassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColor.taskGreyColor,
                      ),
                      onPressed: () {
                        isPassword = !isPassword;
                        setState(() {});
                      },
                    ),
                    hintText: local.confirmHint,
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return local.validateConfirm;
                      }
                      if (value != passwordController.text) {
                        return local.validateConfirm2;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 36.h),
                  InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await FirebaseFunctions.register(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                          userName: nameController.text,
                          onSuccess: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomeScreen.routeName,
                              (route) => false,
                            );
                          },
                          onError: (errorMessage) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                    dialogContent: errorMessage,
                                    dialogTitle: local.error);
                              },
                            );
                          },
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: customButton(
                          borderColor: provider.themeMode == ThemeMode.light
                              ? AppColor.primaryColor
                              : AppColor.primaryDarkColor,
                          color: provider.themeMode == ThemeMode.light
                              ? AppColor.primaryColor
                              : AppColor.primaryDarkColor,
                          borderRadius: BorderRadius.circular(8.r),
                          child: Text(
                            local.create,
                            style: AppStyles.bodyM
                                .copyWith(color: AppColor.whiteColor),
                          ),
                          height: 45.h),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 1,
                            endIndent: 10,
                            color: AppColor.dividerColor,
                          ),
                        ),
                        Text(local.or,
                            textAlign: TextAlign.center,
                            style: AppStyles.regularText.copyWith(
                                fontSize: 14.sp,
                                color: provider.themeMode == ThemeMode.light
                                    ? AppColor.blackColor
                                    : AppColor.whiteColor)),
                        const Expanded(
                          child: Divider(
                            thickness: 1,
                            indent: 10,
                            color: AppColor.dividerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SignWithWidget(
                      iconPath: AppImages.google, iconText: local.google),
                  SizedBox(height: 20.h),
                  SignWithWidget(
                      iconPath: AppImages.facebook, iconText: local.facebook),
                  SizedBox(height: 30.h),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: local.haveAccount,
                            style: AppStyles.settingTitle.copyWith(
                                fontSize: 15.sp,
                                color: provider.themeMode == ThemeMode.light
                                    ? AppColor.inactiveDayColor
                                    : AppColor.taskGreyColor),
                          ),
                          TextSpan(
                            text: local.login,
                            style: AppStyles.settingTitle.copyWith(
                                color: provider.themeMode == ThemeMode.light
                                    ? AppColor.blackColor
                                    : AppColor.whiteColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

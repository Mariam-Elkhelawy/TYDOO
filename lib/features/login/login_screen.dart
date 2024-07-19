import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/components/reusable_components.dart';
import 'package:todo_app/core/components/signwith_widget.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/forget%20password/forget_password.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/features/register/register_screen.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;
    return customBG(
      context: context,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 100.h),
                  Text(
                    local.login,
                    style: AppStyles.titleL.copyWith(
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.blackColor
                            : AppColor.whiteColor),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    textAlign: TextAlign.start,
                    local.welcome,
                    style: AppStyles.settingTitle.copyWith(
                        color: AppColor.taskGreyColor, fontSize: 15.sp),
                  ),
                  SizedBox(height: 50.h),
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
                      controller: emailController,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 18.h),
                      radius: 10.r,
                      hintStyle: AppStyles.hintText.copyWith(
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.blackColor.withOpacity(.5)
                            : AppColor.whiteColor.withOpacity(.5),
                      ),
                      cursorColor: provider.themeMode == ThemeMode.light
                          ? AppColor.primaryColor
                          : AppColor.primaryDarkColor,
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
                        return null;
                      }),
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
                    borderColor: AppColor.borderColor,
                    cursorColor: provider.themeMode == ThemeMode.light
                        ? AppColor.primaryColor
                        : AppColor.primaryDarkColor,
                    fillColor: Colors.transparent,
                    controller: passwordController,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                    radius: 10.r,
                    isPassword: isPassword,
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
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return local.validatePassword;
                      }
                      return null;
                    },
                    hintText: local.passwordHint,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: provider.themeMode == ThemeMode.light
                            ? AppColor.primaryColor
                            : AppColor.primaryDarkColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        local.remember,
                        style: AppStyles.regularText.copyWith(
                            fontSize: 14.sp,
                            color: provider.themeMode == ThemeMode.light
                                ? AppColor.blackColor
                                : AppColor.whiteColor),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          Navigator.pushNamed(
                              context, ForgetPasswordScreen.routeName);
                        },
                        child: Text(
                          local.forgetPassword,
                          style: AppStyles.regularText.copyWith(
                              fontSize: 14.sp,
                              color: provider.themeMode == ThemeMode.light
                                  ? AppColor.blackColor
                                  : AppColor.whiteColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 36.h),
                  InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await FirebaseFunctions.login(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
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
                            local.login,
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
                        Text(
                          local.or,
                          textAlign: TextAlign.center,
                          style: AppStyles.regularText.copyWith(
                              fontSize: 14.sp,
                              color: provider.themeMode == ThemeMode.light
                                  ? AppColor.blackColor
                                  : AppColor.whiteColor),
                        ),
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
                      Navigator.pushNamed(
                        context,
                        RegisterScreen.routeName,
                      );
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: local.notHaveAccount,
                            style: AppStyles.settingTitle.copyWith(
                                fontSize: 15.sp,
                                color: provider.themeMode == ThemeMode.light
                                    ? AppColor.inactiveDayColor
                                    : AppColor.taskGreyColor),
                          ),
                          TextSpan(
                              text: local.signup,
                              style: AppStyles.settingTitle.copyWith(
                                  color: provider.themeMode == ThemeMode.light
                                      ? AppColor.blackColor
                                      : AppColor.whiteColor)),
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

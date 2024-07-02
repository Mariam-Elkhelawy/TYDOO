import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/components/reusable_components.dart';
import 'package:todo_app/core/components/signwith_widget.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
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
    var theme = Theme.of(context);
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
                    style:
                        AppStyles.titleL.copyWith(color: AppColor.blackColor),
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
                    style: AppStyles.regularText.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(height: 6.h),
                  customTextFormField(
                      borderColor: AppColor.borderColor,
                      fillColor: AppColor.whiteColor,
                      controller: emailController,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 18.h),
                      radius: 10.r,
                      hintStyle: AppStyles.hintText,
                      textStyle:
                          AppStyles.generalText.copyWith(fontSize: 15.sp),
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
                    style: AppStyles.regularText.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(height: 6.h),
                  customTextFormField(
                    borderColor: AppColor.borderColor,
                    fillColor: AppColor.whiteColor,
                    controller: passwordController,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                    radius: 10.r,
                    isPassword: isPassword,
                    hintStyle: AppStyles.hintText,
                    textStyle: AppStyles.generalText.copyWith(fontSize: 15.sp),
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
                      const Icon(
                        Icons.check_circle,
                        color: AppColor.primaryColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Remember me',
                        style: AppStyles.regularText.copyWith(fontSize: 14.sp),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          await FirebaseFunctions.resetPassword(
                              emailController.text);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                  dialogContent: local.resetPassword,
                                  dialogTitle: local.reset);
                            },
                          );
                        },
                        child: Text(
                          local.forgetPassword,
                          style:
                              AppStyles.regularText.copyWith(fontSize: 14.sp),
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
                          borderColor: AppColor.primaryColor,
                          color: AppColor.primaryColor,
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
                          style: theme.textTheme.bodyMedium,
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
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RegisterScreen.routeName,
                        (route) => false,
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
                                color: AppColor.inactiveDayColor),
                          ),
                          TextSpan(
                              text: local.signup,
                              style: AppStyles.settingTitle),
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

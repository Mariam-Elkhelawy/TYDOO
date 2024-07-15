import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/components/reusable_components.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/login/login_screen.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/widgets/custom_dialog.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  static const String routeName = 'ForgetPassword';
  TextEditingController emailController = TextEditingController();
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 100.h),
                  IconButton(
                    alignment: provider.languageCode == 'en'
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    onPressed: () => Navigator.pop(context),
                    icon: ImageIcon(
                      const AssetImage(AppImages.arrow),
                      color: provider.themeMode == ThemeMode.light
                          ? AppColor.primaryColor
                          : AppColor.primaryDarkColor,
                    ),
                  ),
                  SvgPicture.asset(
                    AppImages.forgetPassword,
                    height: 220.h,
                  ),
                  Text(
                    local.forgetPassword,
                    textAlign: TextAlign.center,
                    style: AppStyles.bodyL,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Don’t worry! It happens. Please enter the email associated with your account.',
                    textAlign: TextAlign.center,
                    style: AppStyles.hintText.copyWith(
                        color: AppColor.blackColor.withOpacity(.7),
                        fontSize: 15.sp),
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
                  SizedBox(height: 50.h),
                  InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await FirebaseFunctions.resetPassword(
                            emailController.text);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                                dialogContent: local.resetPassword,
                                dialogTitle: local.reset);
                          },
                        ).then((value) => Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName));
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: customButton(
                          borderColor: AppColor.primaryColor,
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(8.r),
                          child: Text(
                            'Reset Password',
                            style: AppStyles.bodyM
                                .copyWith(color: AppColor.whiteColor),
                          ),
                          height: 45.h),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

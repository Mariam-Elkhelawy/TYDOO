import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/features/login/login_screen.dart';
import 'package:todo_app/features/onboarding/gradient_text.dart';
import 'package:todo_app/features/onboarding/onboarding_widget.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColor.onboardingColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(
                () {
                  currentPage = index;
                },
              );
            },
            children:  [
              OnboardingWidget(
                image: AppImages.onboarding3,
                title: local.onBoardingT1,
                description: local.onBoardingD1,
              ),
              OnboardingWidget(
                image: AppImages.onboarding1,
                title: local.onBoardingT2,
                description: local.onBoardingD2,
              ),
              OnboardingWidget(
                image: AppImages.onboarding2,
                title: local.onBoardingT3,
                description: local.onBoardingD3,
              ),
            ],
          ),
          Positioned(
            bottom: 30.0.h,
            left: 30.0.w,
            right: 30.0.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentPage == 2
                    ? TextButton(onPressed: () {}, child: const Text(''))
                    : TextButton(
                        onPressed: () {
                          FirebaseFunctions.isLoggedBefore()
                              ? Navigator.pushNamed(
                                  context, HomeScreen.routeName)
                              : Navigator.pushNamed(
                                  context, LoginScreen.routeName);
                        },
                        child: GradientText(
                         local.skip,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                Row(
                  children: List.generate(
                    3,
                    (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                        width: currentPage == index ? 40.w : 10.0.w,
                        height: currentPage == index ? 10.h : 10.0.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(4.r),
                          gradient: LinearGradient(
                            colors: [
                              AppColor.gradient[0],
                              currentPage == index
                                  ? AppColor.gradient[1]
                                  : AppColor.gradient[0],
                              currentPage == index
                                  ? AppColor.gradient[2]
                                  : AppColor.gradient[0],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (currentPage == 2) {
                      FirebaseFunctions.isLoggedBefore()
                          ? Navigator.pushNamed(context, HomeScreen.routeName)
                          : Navigator.pushNamed(context, LoginScreen.routeName);
                    } else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColor.gradient,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      child: Text(
                        currentPage == 2 ? local.doneO : local.next,
                        style: AppStyles.bodyM.copyWith(
                            fontSize: 14.sp, color: AppColor.whiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/features/onboarding/onboarding_widget.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFa6a0ae),
      body: Stack(alignment: Alignment.center,
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
            children: const [
              OnboardingWidget(
                image: 'assets/images/onboarding3.png',
                title: 'Welcome to ToDo App',
                description: 'Keep track of your tasks easily!',
              ),
              OnboardingWidget(
                image: 'assets/images/om.jpg',
                title: 'Organize by Categories',
                description: 'Categorize your tasks for better management.',
              ),
              OnboardingWidget(
                image: 'assets/images/mm.jpg',
                title: 'Set Reminders',
                description: 'Never miss a deadline with reminders.',
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
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        },
                        child: Text(
                          'skip',
                          style: AppStyles.bodyM.copyWith(
                              color: AppColor.primaryColor, fontSize: 14.sp),
                        ),
                      ),
                Row(
                  children: List.generate(3, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                      width: currentPage == index ? 45.w : 12.0.w,
                      height: currentPage == index ? 12.h : 12.0.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15),
                        color: currentPage == index
                            ? AppColor.primaryColor
                            : AppColor.secondaryColor.withOpacity(.8),
                      ),
                    );
                  }),
                ),
                InkWell(
                  onTap: () {
                    if (currentPage == 2) {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    } else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Text(
                        currentPage == 2 ? 'done' : 'next',
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



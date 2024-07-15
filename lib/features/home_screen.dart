import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/components/reusable_components.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/app_strings.dart';
import 'package:todo_app/features/active_icon_nav_bar.dart';
import 'package:todo_app/features/category/category_tab.dart';
import 'package:todo_app/features/home/add_task_screen.dart';
import 'package:todo_app/features/home/home_tab.dart';
import 'package:todo_app/features/important/important_tab.dart';
import 'package:todo_app/features/settings/settings_tab.dart';
import 'package:todo_app/providers/my_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return customBG(
      context: context,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, AddTaskScreen.routeName);
          },
          child: const Icon(
            Icons.add,
            size: 32,
            color: AppColor.whiteColor,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 0,
          shape: const CircularNotchedRectangle(),
          // shadowColor: Colors.black.withOpacity(.3),
          elevation: 0,
          padding: EdgeInsets.zero,
          child: BottomNavigationBar(
            currentIndex: provider.index,
            onTap: provider.changeIndex,
            backgroundColor: AppColor.whiteColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: provider.themeMode == ThemeMode.light
                ? AppColor.primaryColor
                : AppColor.whiteColor,
            unselectedItemColor: AppColor.secondaryColor,
            iconSize: 24,
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            elevation: 20,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.home),
                  activeIcon: const ActiveIcon(image: AppImages.home),
                  label: AppStrings.home),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.list_outlined), label: AppStrings.category),
              // const BottomNavigationBarItem(
              //     icon: Icon(Icons.star_border,color: AppColor.whiteColor,), label:''),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.star_border), label: AppStrings.important),

              const BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/images/ic_Settings.png')),
                  label: AppStrings.settings),
            ],
          ),
        ),
        body: screens[provider.index],
      ),
    );
  }
}

List<Widget> screens = [
  const HomeTab(),
  const CategoryTab(),
  const ImportantTab(),
   const SettingsTab(),
];

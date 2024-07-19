import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/components/reusable_components.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/features/active_icon_nav_bar.dart';
import 'package:todo_app/features/category/category_tab.dart';
import 'package:todo_app/features/home/add_task_screen.dart';
import 'package:todo_app/features/home/home_tab.dart';
import 'package:todo_app/features/important/important_tab.dart';
import 'package:todo_app/features/settings/settings_tab.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;
    return customBG(
      context: context,
      child: Scaffold(
        backgroundColor:provider.themeMode==ThemeMode.light? Colors.transparent:Colors.transparent,
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor:provider.themeMode == ThemeMode.light
              ? AppColor.primaryColor:AppColor.primaryDarkColor,
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
            backgroundColor: provider.themeMode == ThemeMode.light
                ? AppColor.whiteColor
                : AppColor.darkColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: provider.themeMode == ThemeMode.light
                ? AppColor.primaryColor
                : AppColor.whiteColor,
            unselectedItemColor: provider.themeMode == ThemeMode.light
                ? AppColor.secondaryColor
                : AppColor.colorPalette[4],
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
                  label: local.home),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.list_outlined), label: local.category),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.star_border), label: local.important),
              BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage(AppImages.icSettings),
                  ),
                  label: local.settings),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/features/home/home_tab.dart';
import 'package:todo_app/features/settings/settings_screen.dart';
import 'package:todo_app/features/tasks/add_task_bottom_sheet.dart';
import 'package:todo_app/features/tasks/add_task_screen.dart';
import 'package:todo_app/features/tasks/category_tab.dart';
import 'package:todo_app/providers/my_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, AddTaskScreen.routeName);
          // showModalBottomSheet(
          //     isScrollControlled: true,
          //     context: context,
          //     builder: (context) {
          //       return Container(
          //           padding: EdgeInsets.only(
          //               bottom: MediaQuery.of(context).viewInsets.bottom),
          //           child: const AddTaskBottomSheet());
          //     });
        },
        child: const Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin:0,
        shape: const CircularNotchedRectangle(),
        // shadowColor: Colors.black.withOpacity(.3),
        elevation: 0,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          currentIndex: provider.index,
          onTap: provider.changeIndex,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: provider.themeMode == ThemeMode.light
              ? AppTheme.primaryColor
              : Colors.white,
          unselectedItemColor: AppTheme.secondaryColor,
          iconSize: 24,
          selectedFontSize: 12,
          elevation: 0,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted), label: 'Category'),
            // BottomNavigationBarItem(icon: Icon(Icons.add,color: Colors.white,), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Important'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: 'Settings'),
          ],
        ),
      ),
      body: screens[provider.index],
    );
  }
}

List<Widget> screens = [
  const HomeTab(),
  const CategoryTab(),
  SettingsScreen(),
  SettingsScreen(),
];

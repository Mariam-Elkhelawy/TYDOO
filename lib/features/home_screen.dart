import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/features/settings/settings_screen.dart';
import 'package:todo_app/features/tasks/add_task_bottom_sheet.dart';
import 'package:todo_app/features/tasks/task_screen.dart';
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
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddTaskBottomSheet());
              });
        },
        child: const Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 12,
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          currentIndex: provider.index,
          onTap: provider.changeIndex,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: AppTheme.greyColor,
          iconSize: 33,
          elevation: 0,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted), label: ''),
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: ''),
          ],
        ),
      ),
      body: screens[provider.index],
    );
  }
}

List<Widget> screens = [const TaskScreen(),  SettingsScreen()];

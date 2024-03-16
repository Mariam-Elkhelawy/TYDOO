import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/features/login/login_screen.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  List<String> langList = ['English', 'العربيه'];
  List<String> themeList = ['dark', 'light'];
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    return Column(
      children: [
        Container(
          color: AppTheme.primaryColor,
          width: mediaQuery.width,
          height: mediaQuery.height * .24,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(45, 0, 20, 0),
            child: Row(
              children: [
                Text(
                  'Settings',
                  style: theme.textTheme.titleLarge,
                ),
                Spacer(),
                InkWell(
                  onTap: () async {
                    await FirebaseFunctions.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginScreen.routeName,
                      (route) => false,
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Log Out',
                        style:
                            theme.textTheme.titleLarge?.copyWith(fontSize: 14),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.logout,
                        color: provider.themeMode == ThemeMode.dark
                            ? const Color(0xFF060E1E)
                            : Colors.white,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(25, 25, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Language',
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 14),
              CustomDropdown(hintText: 'Select Language',
                decoration: CustomDropdownDecoration(
                    closedBorderRadius: BorderRadius.zero,
                    expandedBorderRadius: BorderRadius.zero,
                    headerStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppTheme.primaryColor),
                    listItemStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppTheme.primaryColor),
                    closedBorder: Border.all(color: AppTheme.primaryColor),
                  closedFillColor:provider.themeMode==ThemeMode.dark? AppTheme.blackColor:Colors.white,
                  expandedFillColor: provider.themeMode==ThemeMode.dark? AppTheme.blackColor:Colors.white,
                ),
                items: langList,
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              Text(
                'Theme',
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 14),
              CustomDropdown(hintText: 'Select Theme',
                decoration: CustomDropdownDecoration(
                    // expandedBorder: Border.all(color: AppTheme.primaryColor),
                    closedBorderRadius: BorderRadius.zero,
                    expandedBorderRadius: BorderRadius.zero,
                    headerStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppTheme.primaryColor),
                    listItemStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppTheme.primaryColor),
                    closedBorder: Border.all(color: AppTheme.primaryColor),
                    closedFillColor:provider.themeMode==ThemeMode.dark? AppTheme.blackColor:Colors.white,
                    expandedFillColor: provider.themeMode==ThemeMode.dark? AppTheme.blackColor:Colors.white,
                ),
                items: themeList,
                onChanged: (value) {},
              )
            ],
          ),
        )
      ],
    );
  }
}

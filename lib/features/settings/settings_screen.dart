import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/features/login/login_screen.dart';
import 'package:todo_app/features/settings/DropDownWidget.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;
    List<String> langList = [local.english, local.arabic];
    List<String> themeList = [local.dark, local.light];
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
                  local.settings,
                  style: theme.textTheme.titleLarge,
                ),
                const Spacer(),
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
                        local.logout,
                        style:
                            theme.textTheme.titleLarge?.copyWith(fontSize: 14),
                      ),
                      const SizedBox(width: 6),
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
                local.language,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 14),
              CustomDropDownWidget(
                  initialItem: provider.languageCode == 'en'
                      ? local.english
                      : local.arabic,
                  onChanged: (value) {
                    if (value == local.arabic) {
                      provider.changeLanguageCode('ar');
                    } else if (value == local.english) {
                      provider.changeLanguageCode('en');
                    }
                  },
                  hintText: local.selectLanguage,
                  items: langList),
              const SizedBox(height: 20),
              Text(
                local.theme,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 14),
              CustomDropDownWidget(
                  initialItem: provider.themeMode == ThemeMode.light
                      ? local.light
                      : local.dark,
                  onChanged: (value) {
                    if (value == local.dark) {
                      provider.changeThemeMode(ThemeMode.dark);
                    } else if (value == local.light) {
                      provider.changeThemeMode(ThemeMode.light);
                    }
                  },
                  hintText: local.selectTheme,
                  items: themeList),
            ],
          ),
        )
      ],
    );
  }
}

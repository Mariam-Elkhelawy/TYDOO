import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_theme.dart';
import 'package:todo_app/providers/my_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
            padding: const EdgeInsetsDirectional.fromSTEB(45, 85, 0, 0),
            child: Text(
              'Settings',
              style: theme.textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}

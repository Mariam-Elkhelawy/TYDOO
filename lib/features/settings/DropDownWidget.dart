import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/providers/my_provider.dart';

class CustomDropDownWidget extends StatelessWidget {
  CustomDropDownWidget(
      {super.key,
      required this.onChanged,
      required this.hintText,
      required this.items,
      required this.initialItem});
  List<String> items;
  String hintText;
  String initialItem;
  dynamic Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    return CustomDropdown(
        initialItem: initialItem,
        hintText: hintText,
        decoration: CustomDropdownDecoration(
          closedSuffixIcon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColor.primaryColor,
          ),
          expandedSuffixIcon: const Icon(
            Icons.keyboard_arrow_up,
            color: AppColor.primaryColor,
          ),
          closedBorderRadius: BorderRadius.zero,
          expandedBorderRadius: BorderRadius.zero,
          headerStyle: theme.textTheme.bodyMedium
              ?.copyWith(color: AppColor.primaryColor),
          listItemStyle: theme.textTheme.bodyMedium
              ?.copyWith(color: AppColor.primaryColor),
          closedBorder: Border.all(color: AppColor.primaryColor),
          closedFillColor: provider.themeMode == ThemeMode.dark
              ? AppColor.blackColor
              : Colors.white,
          expandedFillColor: provider.themeMode == ThemeMode.dark
              ? AppColor.blackColor
              : Colors.white,
        ),
        items: items,
        onChanged: onChanged);
  }
}

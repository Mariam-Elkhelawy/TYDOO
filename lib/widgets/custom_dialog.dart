import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog(
      {super.key,
      required this.dialogContent,
      required this.dialogTitle,
      this.actionRequired,
      this.icon,this.is2Actions=false});
  String dialogTitle;
  String dialogContent;
  VoidCallback? actionRequired;
  Widget? icon;
  bool is2Actions ;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AlertDialog(
      title: icon != null
          ? Row(
              children: [
                SizedBox(child: icon),
                SizedBox(
                  width: 8
                ),
                Text(dialogTitle),
              ],
            )
          : Text(dialogTitle),
      content: Text(dialogContent),
      actions: [
        ElevatedButton(
          onPressed: () {
            actionRequired?.call();
            Navigator.pop(context);
          },
          child: Text(
            'OK',
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
        if(is2Actions)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
      ],
    );
  }
}

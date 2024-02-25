import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_theme.dart';
import 'package:todo_app/providers/my_provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
      height: 115,
      decoration: BoxDecoration(
        color:provider.themeMode==ThemeMode.light? Colors.white:AppTheme.blackColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 65,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Play basket ball',
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.timer_outlined,size: 18),
                  SizedBox(width: 5),
                  Text(
                    '10:30 Am',
                    style: theme.textTheme.bodySmall,
                  )
                ],
              )
            ],
          ),
          Spacer(),
          Container(height: 35,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(10),),
            child: Icon(
              Icons.check_rounded,
              size: 35,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

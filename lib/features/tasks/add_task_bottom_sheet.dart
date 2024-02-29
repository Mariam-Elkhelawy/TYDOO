import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/features/tasks/task_model.dart';
import 'package:todo_app/firebase/firebase_functions.dart';

import '../../providers/my_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime chosenDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add New Task',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: provider.themeMode == ThemeMode.dark
                  ? Colors.white
                  : AppTheme.darkColor,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(controller: titleController,
            decoration: InputDecoration(
              hintText: 'enter your task title',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppTheme.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF707070),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(controller: descriptionController,
            decoration: InputDecoration(
              hintText: 'enter your task details',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppTheme.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF707070),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select date',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                color: provider.themeMode == ThemeMode.dark
                    ? const Color(0xFFC3C3C3)
                    : AppTheme.darkColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              selectDate(context);
            },
            child: Text(
               chosenDate.toString().substring(0, 10),
              style:
                  GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(height: 35),
          InkWell(onTap: () {
          TaskModel taskModel=  TaskModel(title: titleController.text, date: chosenDate.millisecondsSinceEpoch, description: descriptionController.text);
            FirebaseFunctions.addTask(taskModel);
          },
            child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(10),),
              width: double.infinity,
              height: 35,
              child: Center(
                child: Text(
                  'Add Task',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12)
        ],
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        initialDate: chosenDate);
    if (selectedDate != null) {
      chosenDate = selectedDate;
      setState(() {});
    }
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/features/models/task_model.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/edit_provider.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    return ChangeNotifierProvider<EditProvider>(
      create: (context) => EditProvider(),
      builder: (context, child) {
        var editProvider = Provider.of<EditProvider>(context);

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
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
                CustomTextFormField(
                  myController: titleController,
                  hintText: 'enter your task title',
                  onValidate: (value) {
                    if (value!.trim().isEmpty || value == null) {
                      return "Task title can't be empty!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'enter your task description',
                  myController: descriptionController,
                  onValidate: (value) {
                    if (value!.trim().isEmpty || value == null) {
                      return "Task description can't be empty!";
                    }
                    return null;
                  },
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
                    editProvider.selectDate(context);
                  },
                  child: Text(
                    DateFormat.yMMMEd().format(editProvider.chosenDate),
                    style: GoogleFonts.inter(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 35),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      TaskModel taskModel = TaskModel(
                          title: titleController.text,
                          date: DateUtils.dateOnly(editProvider.chosenDate),
                          description: descriptionController.text);
                      FirebaseFunctions.addTask(taskModel).then(
                        (value) {
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    height: 35,
                    child: Center(
                      child: Text(
                        'Add Task',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12)
              ],
            ),
          ),
        );
      },
    );
  }
}

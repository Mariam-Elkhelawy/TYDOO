import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/features/data/models/task_model.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/edit_provider.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_dialog.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;

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
                  local.addTask,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: provider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : AppColor.darkColor,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  myController: titleController,
                  hintText: local.enterTitle,
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return local.validateTitle;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: local.enterDescription,
                  myController: descriptionController,
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return local.validateDescription;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    local.selectDate,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                      color: provider.themeMode == ThemeMode.dark
                          ? const Color(0xFFC3C3C3)
                          : AppColor.darkColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    editProvider.selectDate(context);
                  },
                  child: Text(
                    DateFormat.yMMMd(
                        provider.languageCode == 'en' ? 'en' : 'ar')
                        .format(editProvider.chosenDate),
                    style: GoogleFonts.inter(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 35),
                InkWell(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      TaskModel taskModel = TaskModel(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          id: '',
                          title: titleController.text,
                          date: DateUtils.dateOnly(editProvider.chosenDate),
                          description: descriptionController.text);
                      await FirebaseFunctions.addTask(taskModel);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            dialogContent: local.addTaskSuccess,
                            dialogTitle: local.success,
                            actionRequired: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    height: 35,
                    child: Center(
                      child: Text(
                        local.addTaskButton,
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

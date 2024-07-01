import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/features/data/models/task_model.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/edit_provider.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_dialog.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key});
  static const String routeName = 'EditTaskScreen';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TaskModel? model;
  DateTime? chosenDate;
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;

    return ChangeNotifierProvider<EditProvider>(
      create: (context) => EditProvider(),
      builder: (context, child) {
        var editProvider = Provider.of<EditProvider>(context);
        chosenDate = DateUtils.dateOnly(editProvider.chosenDate);
        if (model == null) {
          model = ModalRoute.of(context)!.settings.arguments as TaskModel;
          titleController.text = model!.title;
          descriptionController.text = model!.description;
          chosenDate = model!.date;
        }
        return Drawer(
          child: Form(
            key: formKey,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Scaffold(),
                Container(
                  color: AppColor.primaryColor,
                  width: mediaQuery.width,
                  height: mediaQuery.height * .24,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(45, 85, 0, 0),
                    child: Text(
                      local.todoList,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: provider.themeMode == ThemeMode.light
                          ? Colors.white
                          : AppColor.blackColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: mediaQuery.height * .69,
                    width: mediaQuery.width * .76,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            local.editTask,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: provider.themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : AppColor.darkColor,
                            ),
                          ),
                          SizedBox(height: mediaQuery.height * .04),
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
                          SizedBox(height: mediaQuery.height * .025),
                          CustomTextFormField(
                              hintText: local.enterDescription,
                              onValidate: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return local.validateDescription;
                                }
                                return null;
                              },
                              myController: descriptionController),
                          SizedBox(height: mediaQuery.height * .025),
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
                          SizedBox(height: mediaQuery.height * .025),
                          InkWell(
                            onTap: () {
                              setState(
                                () {
                                  editProvider.selectDate(context);
                                  isTapped = true;
                                },
                              );
                            },
                            child: chosenDate == null
                                ? null
                                : Text(
                                    DateFormat.yMMMEd(
                                            provider.languageCode == 'en'
                                                ? 'en'
                                                : 'ar')
                                        .format(isTapped
                                            ? chosenDate!
                                            : model!.date),
                                    style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                          ),
                          SizedBox(height: mediaQuery.height * .1),
                          InkWell(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                if (descriptionController.text ==
                                        model!.description &&
                                    titleController.text == model!.title &&
                                    chosenDate == model!.date) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialog(
                                          dialogContent: local.noChanges,
                                          dialogTitle: local.alert);
                                    },
                                  );
                                  return;
                                }
                                model!.title = titleController.text;
                                model!.description = descriptionController.text;
                                model!.date =
                                    DateUtils.dateOnly(editProvider.chosenDate);
                                try {
                                  await FirebaseFunctions.updateTask(model!);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialog(
                                          actionRequired: () {
                                            Navigator.pop(context);
                                          },
                                          dialogContent: local.editTaskSuccess,
                                          dialogTitle: local.success);
                                    },
                                  );
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(local.error),
                                        content: Text('$e'),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              local.ok,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              width: mediaQuery.width * .65,
                              height: 55,
                              child: Center(
                                child: Text(
                                  local.saveEdit,
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

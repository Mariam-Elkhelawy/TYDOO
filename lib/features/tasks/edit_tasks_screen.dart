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

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key});
  static const String routeName = 'EditTaskScreen';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  bool isTapped = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var model = ModalRoute.of(context)!.settings.arguments as TaskModel;
    var provider = Provider.of<MyProvider>(context);
    return ChangeNotifierProvider<EditProvider>(
      create: (context) => EditProvider(),
      builder: (context, child) {
        var editProvider = Provider.of<EditProvider>(context);
        DateTime chosenDate = editProvider.chosenDate;

        return Drawer(
          child: Form(
            key: formKey,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Scaffold(),
                Container(
                  color: AppTheme.primaryColor,
                  width: mediaQuery.width,
                  height: mediaQuery.height * .24,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(45, 85, 0, 0),
                    child: Text(
                      'To Do List',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: provider.themeMode == ThemeMode.light
                          ? Colors.white
                          : AppTheme.blackColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: mediaQuery.height * .69,
                    width: mediaQuery.width * .76,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            'Edit Task',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: provider.themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : AppTheme.darkColor,
                            ),
                          ),
                          SizedBox(height: mediaQuery.height * .04),
                          CustomTextFormField(
                            myController:
                                TextEditingController(text: model.title),
                          ),
                          SizedBox(height: mediaQuery.height * .025),
                          CustomTextFormField(
                            myController:
                                TextEditingController(text: model.description),
                          ),
                          SizedBox(height: mediaQuery.height * .025),
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
                          SizedBox(height: mediaQuery.height * .025),
                          InkWell(
                            onTap: () {
                              setState(() {
                                editProvider.selectDate(context);
                                isTapped = true;
                              });
                            },
                            child: Text(
                              DateFormat.yMMMEd()
                                  .format(isTapped ? chosenDate : model.date),
                              style: GoogleFonts.inter(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: mediaQuery.height * .1),
                          InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                model.date = chosenDate;
                                FirebaseFunctions.updateTask(model)
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              width: mediaQuery.width * .65,
                              height: 55,
                              child: Center(
                                child: Text(
                                  'Save changes',
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

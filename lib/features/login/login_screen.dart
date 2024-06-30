import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/features/register/register_screen.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_dialog.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    var local = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: provider.themeMode == ThemeMode.light
            ? const Color(0xFFDFECDB)
            : const Color(0xFF060E1E),
        image: const DecorationImage(
            image: AssetImage('assets/images/auth_bg.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: mediaQuery.height * .11),
                  Text(
                    textAlign: TextAlign.center,
                    local.login,
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: mediaQuery.height * .2),
                  Text(
                    textAlign: TextAlign.start,
                    local.welcome,
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 35),
                  Text(local.email),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    myController: emailController,
                    hintText: local.emailHint,
                    suffixIcon: const Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return local.validateEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(local.password),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    myController: passwordController,
                    hintText: local.passwordHint,
                    suffixIcon: IconButton(
                      icon: isPassword
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        isPassword = !isPassword;
                        setState(() {});
                      },
                    ),
                    obscureText: isPassword,
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return local.validatePassword;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await FirebaseFunctions.login(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                          onSuccess: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomeScreen.routeName,
                              (route) => false,
                            );
                          },
                          onError: (errorMessage) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                    dialogContent: errorMessage,
                                    dialogTitle: local.error);
                              },
                            );
                          },
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          local.login,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(fontSize: 14, color: Colors.white),
                        ),
                        const Icon(
                          Icons.arrow_forward_outlined,
                          size: 18,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  InkWell(
                    onTap: () async {
                      await FirebaseFunctions.resetPassword(
                          emailController.text);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                              dialogContent: local.resetPassword, dialogTitle: local.reset);
                        },
                      );
                    },
                    child: Text(
                      local.forgetPassword,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    local.or,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(
                      local.createAccount,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

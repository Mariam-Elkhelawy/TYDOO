import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/features/register/register_screen.dart';
import 'package:todo_app/features/tasks/task_screen.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassword = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
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
                    'Login',
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: mediaQuery.height * .2),
                  Text(
                    textAlign: TextAlign.start,
                    'Welcome back!',
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 35),
                  const Text('E-mail'),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    hintText: 'Enter your e-mail address',
                    suffixIcon: const Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    onValidate: (value) {
                      if (value!.trim().isEmpty || value == null) {
                        return 'You must Enter your E-mail';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Password'),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                        icon: isPassword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          isPassword = !isPassword;
                          setState(() {});
                        }),
                    obscureText: isPassword,
                    onValidate: (value) {
                      if (value!.trim().isEmpty || value == null) {
                        return 'You must Enter your Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Login',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(fontSize: 14, color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          size: 18,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'OR',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(
                      ' Create New Account..',
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

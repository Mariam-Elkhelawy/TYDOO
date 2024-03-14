import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPassword = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          toolbarHeight: 125,
          title: Text(
            'Create Account',
            style: theme.textTheme.titleLarge,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: mediaQuery.height * .16),
                  const Text('Full Name'),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    hintText: 'Enter your Full Name',
                    suffixIcon: const Icon(Icons.person),
                    keyboardType: TextInputType.name,
                    onValidate: (value) {
                      if (value!.trim().isEmpty || value == null) {
                        return 'You must Enter your Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
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
                    myController: passwordController,
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
                  const SizedBox(height: 20),
                  const Text('Confirm Password'),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    myController: confirmPasswordController,
                    hintText: 'Enter your Confirm password',
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
                        return 'You must Enter your Confirm Password';
                      }
                      if (value != passwordController.text) {
                        return 'Password Not matched';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseFunctions.register(emailController.text,
                            passwordController.text, nameController.text);
                        // Navigator.pushNamed(context, HomeScreen.routeName);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Create Account',
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
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

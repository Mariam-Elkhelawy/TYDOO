import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:todo_app/widgets/custom_dialog.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPassword = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          toolbarHeight: 125,
          title: Text(
            local.create,
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
                  Text(local.fullName),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    myController: nameController,
                    hintText: local.nameHint,
                    suffixIcon: const Icon(Icons.person),
                    keyboardType: TextInputType.name,
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return local.validateName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
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
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return local.validateEmail2;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(local.phoneNumber),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    myController: phoneController,
                    hintText: local.phoneHint,
                    suffixIcon: const Icon(Icons.phone),
                    keyboardType: TextInputType.phone,
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return local.validatePhone;
                      }
                      RegExp regex = RegExp(r'^(?:[+0]2)?01[0125][0-9]{8}$');
                      if (!regex.hasMatch(value)) {
                        return local.validatePhone2;
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
                        }),
                    obscureText: isPassword,
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return local.validatePassword;
                      }
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (!regex.hasMatch(value)) {
                        return local.validatePassword2;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(local.confirmPassword),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    myController: confirmPasswordController,
                    hintText: local.confirmHint,
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
                      if (value!.trim().isEmpty) {
                        return local.validateConfirm;
                      }
                      if (value != passwordController.text) {
                        return local.validateConfirm2;
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
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await FirebaseFunctions.register(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                          userName: nameController.text,
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
                          local.create,
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

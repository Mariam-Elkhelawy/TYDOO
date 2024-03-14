import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.myController,
      this.hintText = '',
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.keyboardType,
      this.onValidate});
  TextEditingController? myController = TextEditingController();
  String hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool obscureText;
  TextInputType? keyboardType;
  String? Function(String?)? onValidate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      validator: onValidate,
      controller: myController,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1.5,
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
    );
  }
}

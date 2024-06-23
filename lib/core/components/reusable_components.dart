import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/providers/my_provider.dart';

Widget unDefinedRoute() {
  return const Scaffold(
    body: Center(
      child: Text('Route Name Not Found'),
    ),
  );
}

Widget customTextFormField(
    {String? hintText,
    TextStyle? hintStyle,
    required Color borderColor,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextEditingController? controller,
    double radius = 0,
    bool isPassword = false,
    TextStyle? textStyle,
    TextInputType? keyboardType,
    EdgeInsetsGeometry? contentPadding,
    Color? cursorColor = AppColor.primaryColor,
    required Color fillColor,
    String? Function(String?)? onValidate,
    void Function(String)? onChanged,
    String langCode = 'en'}) {
  return TextFormField(
    textDirection: langCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
    keyboardType: keyboardType,
    validator: onValidate,
    style: textStyle,
    obscureText: isPassword,
    cursorColor: cursorColor,
    controller: controller,
    decoration: InputDecoration(
      contentPadding: contentPadding,
      hintText: hintText,
      hintStyle: hintStyle,
      filled: true,
      fillColor: fillColor,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      errorMaxLines: 8,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: borderColor,
          width: 1.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: borderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
  );
}

Container customButton(
    {Widget? child,
    double? width,
    double? height,
    Color? color,
    required Color borderColor,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding}) {
  return Container(
    padding: padding,
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: borderRadius,
      color: color,
      border: Border.all(color: borderColor),
    ),
    child: Center(child: child),
  );
}

// customToast({required String message}) {
//   return Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: AppColor.primaryColor,
//       timeInSecForIosWeb: 3,
//       textColor: AppColor.whiteColor,
//       fontSize: 13.0);
// }

// Widget customLoading() {
//   return Center(
//     child: LoadingIndicator(
//       indicatorType: Indicator.ballTrianglePathColoredFilled,
//       colors: [
//         AppColor.primaryColor,
//         AppColor.secondaryColor,
//         AppColor.textColor
//       ],
//     ),
//   );
// }
//
// Widget customError(String errorMessage) {
//   return SizedBox(
//       width: 300.w,
//       child: Center(
//         child: Text(
//           errorMessage,
//           style: AppStyles.bodyM,
//           textAlign: TextAlign.center,
//         ),
//       ));
// }
Widget customBG({required BuildContext context, Widget? child}) {
  var provider = Provider.of<MyProvider>(context);

  return Container(
    decoration: BoxDecoration(
      color: provider.themeMode == ThemeMode.light
          ? AppColor.whiteColor
          : AppColor.darkColor,
      image: DecorationImage(
          image: AssetImage(provider.themeMode == ThemeMode.light
              ? 'assets/images/bg_light.png'
              : 'assets/images/bd_dark.png'),
          fit: BoxFit.cover),
    ),
    child: child,
  );
}

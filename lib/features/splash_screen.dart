import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/providers/my_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = 'SplashScreen';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return FlutterSplashScreen.fadeIn(
        duration: Duration(seconds: 4),
        backgroundImage:
            provider.themeMode == ThemeMode.light?
        Image(image: AssetImage('assets/images/splash.png')):
        Image(image: AssetImage('assets/images/splash_dark.png')),
        nextScreen: HomeScreen(),
        childWidget: SizedBox());
  }
}

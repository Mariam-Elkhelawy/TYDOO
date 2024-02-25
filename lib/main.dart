import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_theme.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/features/splash_screen.dart';
import 'package:todo_app/providers/my_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<MyProvider>(
      create: (context) => MyProvider(),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      themeMode: provider.themeMode,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen()
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/cache/shared_prefrences.dart';
import 'package:todo_app/features/category/add_category_screen.dart';
import 'package:todo_app/features/forget%20password/forget_password.dart';
import 'package:todo_app/features/home/edit_tasks_screen.dart';
import 'package:todo_app/features/home/notification_screen.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/features/login/login_screen.dart';
import 'package:todo_app/features/register/register_screen.dart';
import 'package:todo_app/features/splash_screen.dart';
import 'package:todo_app/firebase/firebase_functions.dart';
import 'package:todo_app/firebase/firebase_notification.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/providers/my_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'features/home/add_task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  MyProvider myProvider = MyProvider();
  await myProvider.setItems();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FireBaseNotification.initNotifications();
  const fatalError = true;
  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  runApp(
    ChangeNotifierProvider<MyProvider>(
      create: (context) => myProvider,
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        locale: Locale(provider.languageCode),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        themeMode: provider.themeMode,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          EditTaskScreen.routeName: (context) => const EditTaskScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          AddTaskScreen.routeName: (context) => const AddTaskScreen(),
          AddCategoryScreen.routeName: (context) =>  const AddCategoryScreen(),
          ForgetPasswordScreen.routeName: (context) =>   ForgetPasswordScreen(),
          NotificationScreen.routeName: (context) =>   NotificationScreen(),
        },
      ),
    );
  }
}

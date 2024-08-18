import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/home/notification_screen.dart';

class FireBaseNotification {
  static Future<void> initNotifications() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission();
    final fCMToken = await firebaseMessaging.getToken();
    print(fCMToken);
    initPushNotifications();
  }

  static void handleMessage(RemoteMessage? message, {BuildContext? context}) {
    if (message == null) return;
    Navigator.pushNamed(context!, NotificationScreen.routeName,
        arguments: message);
  }

  static Future initPushNotifications() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    print("------------");
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_logo');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      // onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload),async {}
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    await flutterLocalNotificationsPlugin.cancelAll();
  }

  notificationDetails() {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'channelId',
            //Required for Android 8.0 or after
            'channelName',
            //Required for Android 8.0 or after
            channelDescription: 'String',
            //Required for Android 8.0 or after
            importance: Importance.high,
            priority: Priority.high);

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentBadge: true,
      // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentSound: true,
      // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      sound: 'String ?',
      // Specifics the file path to play (only from iOS 10 onwards)
      badgeNumber: 3,
      // The application's icon badge number
      subtitle: 'subtitle',
      //Secondary description  (only from iOS 10 onwards)
      threadIdentifier: 'threadIdentifier', // (only from iOS 10 onwards)
    );

    return const NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinNotificationDetails,
    );
  }

  Future showNotification(
      {required int id, String? title, String? body, String? payload}) async {
    await flutterLocalNotificationsPlugin
        .show(id, title, body, notificationDetails(), payload: payload);
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {}

  }
}

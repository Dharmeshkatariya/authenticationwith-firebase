import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';


class PushNotificationService {
  PushNotificationService();

  Future initialise() async {
    await Firebase.initializeApp();

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    String? deviceToken = await FirebaseMessaging.instance.getToken();
    print("Device Token ===> ${deviceToken ?? ""}");

    if (!kIsWeb) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
    }

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
      }
    });

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage : Message Data ==> ${message.data}");
      print("onMessage : Message Notification ==> ${message.notification}");
      var title = message.data['title'];
      var body = message.data['body'];
    });
  }
}

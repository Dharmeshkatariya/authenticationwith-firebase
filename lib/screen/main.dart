import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/routes/page_routes.dart';
import 'package:untitled5/screen/chatapp_screen.dart';
import '../routes/name_routes.dart';
import 'loginscreen.dart';
import '../notification_service/notification_service.dart';

@pragma("vm-entry point")
Future<void> backgroundHandlerMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  print(message.notification!.title.toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandlerMessage);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: GetMaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        getPages: PageRoutes.pages,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    _login();
    _onNotification();
    NotificationService().init();
    super.initState();
  }
  _onNotification() {
    FirebaseMessaging.onMessage.listen((message) {
      String title = message.notification!.title.toString();
      String body = message.notification!.body.toString();
      NotificationService().showNotification(id: 123, title: title, body: body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Yoga App',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  _login() async {
    var shareP = await SharedPreferences.getInstance();
    bool isLogin = shareP.getBool("login") ?? false;
    Timer(Duration(seconds: 2), () {
      if (isLogin) {
       Get.offNamed(NameRoutes.chatAppScreen);
      } else {
        Get.offNamed(NameRoutes.logInScreen);
      }
    });
  }
}

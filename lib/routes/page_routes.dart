import 'package:get/get.dart';
import 'package:untitled5/binding/addfirestore_binding.dart';
import 'package:untitled5/binding/chatapp_binding.dart';
import 'package:untitled5/binding/loginscreen_binding.dart';
import 'package:untitled5/binding/mobileverified_binding.dart';
import 'package:untitled5/binding/otpscreen_binding.dart';
import 'package:untitled5/binding/signupscreen_binding.dart';
import 'package:untitled5/routes/name_routes.dart';
import 'package:untitled5/screen/chatapp_screen.dart';
import 'package:untitled5/screen/database/add_firestore_data.dart';
import 'package:untitled5/screen/database/add_post.dart';
import 'package:untitled5/screen/loginscreen.dart';
import 'package:untitled5/screen/mobileverification.dart';
import 'package:untitled5/screen/otpscreen.dart';
import 'package:untitled5/screen/signupscreen.dart';

import '../binding/addpost_binding.dart';

class PageRoutes{

  static final pages = [
    GetPage(
        name: NameRoutes.otpScreen,
        page: ()=>OtpScreen(),
      binding: OtpScreenBinding(),
    ),
    GetPage(
      name: NameRoutes.logInScreen,
      page: ()=>LoginScreen(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: NameRoutes.signupScreen,
      page: ()=>SignUpScreen(),
      binding: SignUpScreenBinding(),
    ),
    GetPage(
      name: NameRoutes.addPostScreen,
      page: ()=>AddPost(path: '',),
      binding: AddPostBinding(),
    ),
    GetPage(
      name: NameRoutes.chatAppScreen,
      page: ()=>ChatAppScreen(),
      binding: ChatAppBinding(),
    ),
    GetPage(
      name: NameRoutes.mobileVerifiedScreen,
      page: ()=>MobileScreen(),
      binding: MobileVerifiedBinding(),
    ),
    GetPage(
      name: NameRoutes.addFireStoreScreen,
      page: ()=>AddFirestoreData(),
      binding: AddFirestoreBinding(),
    ),
  ];
}
import 'package:get/get.dart';
import 'package:untitled5/binding/otpscreen_binding.dart';
import 'package:untitled5/routes/name_routes.dart';
import 'package:untitled5/screen/loginscreen.dart';
import 'package:untitled5/screen/otpscreen.dart';

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
      binding: OtpScreenBinding(),
    ),
  ];
}
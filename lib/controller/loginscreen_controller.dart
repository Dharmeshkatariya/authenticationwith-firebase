import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/screen/chatapp_screen.dart';

import '../utils/utills.dart';

class LoginScreenController extends GetxController{

  final emailController = TextEditingController();
  final passController = TextEditingController();
  RxBool loading = false.obs;


  userLogin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.value.text,
        password: passController.value.text,
      )
          .then((value) => Utils.toastMessage("login successfully "));
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      var shareP = await SharedPreferences.getInstance();
      shareP.setString("email", emailController.value.text);
      shareP.setBool("login", true);
      shareP.setString("pass", passController.value.text);
       loading.value = false;
        Get.to(ChatAppScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
    }catch(e){
      print(e);
    }
  }
}
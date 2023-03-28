import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common.dart';
import '../routes/name_routes.dart';
import '../utils/utills.dart';

class MobileScreenController extends GetxController{

  final mobileController = TextEditingController();
  RxBool loading = false.obs;
  final form = GlobalKey<FormState>();

  mobileVerified() async {
    try{
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.verifyPhoneNumber(
        phoneNumber: "+91 ${mobileController.value.text}",
        verificationFailed: (FirebaseAuthException e) {
        },
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await auth
          //     .signInWithCredential(credential)
          //     .then((value) => print('Logged In Successfully'));
        },

        codeSent: (String verificationId, int? resendToken) async {

          Common.verificationId = verificationId;
          var receivedID = verificationId;
          var shareP = await SharedPreferences.getInstance();
          shareP.setString("receive", receivedID);
          loading.value = false;
          Get.toNamed(NameRoutes.otpScreen);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
        },
      ).then((value) => Utils.toastMessage("Verifivation code send in message")).onError((error, stackTrace) =>
          Utils.toastMessage(error.toString()));
    }catch(e){
      print(e);
    }
  }

}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common.dart';
import '../utils/utills.dart';

class OtpScreenController extends GetxController{

  final otpController = TextEditingController();
  RxString receivedID = "".obs ;
  RxBool loading = false.obs;

  verifyOTPCode() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var shareP = await SharedPreferences.getInstance();
    try {
      receivedID.value = shareP.getString("receive")!;
      String verificationId = Common.verificationId;
      String otp = otpController.value.text.trim();

      UserCredential userCred = await auth
          .signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp,
        ),
      )
          .then((value) => Utils.toastMessage("User login syccesfully "));
      loading.value = false;
      shareP.setBool("login", true);

    } catch (e) {
      print(e);
    }
  }
}
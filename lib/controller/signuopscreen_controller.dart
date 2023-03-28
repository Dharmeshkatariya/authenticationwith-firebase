import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/loginscreen.dart';

import '../utils/utills.dart';

class SignUpScreenController extends GetxController {
  RxBool isChecked = false.obs;
  RxBool loading = false.obs;
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final passController = TextEditingController();
  final emailController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref("User");
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  databaseProfile() {
    if (nameController.value.text.isNotEmpty &&
        emailController.value.text.isNotEmpty &&
        mobileController.value.text.isNotEmpty &&
        passController.value.text.isNotEmpty) {
      String email = emailController.value.text;
      var strEmail = email.split("@");
      databaseRef.child(strEmail[0]).set({
        "fullName": nameController.value.text,
        "email": emailController.value.text,
        "Mobile": mobileController.value.text,
        "password": passController.value.text,
      });
      Get.to(LoginScreen());
    }
  }

  createUser() async {
    try {
      loading.value = true;
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.value.text,
        password: passController.value.text,
      )
          .then((value) => Get.snackbar("signup", "successfully",backgroundColor: Colors.orange))
          .onError((error, stackTrace) => Get.snackbar("signup", "$error",backgroundColor: Colors.orange));
      var shareP = await SharedPreferences.getInstance();
      shareP.setString("email", emailController.value.text);
      shareP.setString("pass", passController.value.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
      }
    } catch (e) {
      print(e);
    }
  }
}

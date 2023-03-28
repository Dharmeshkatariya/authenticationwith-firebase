import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/utils/utills.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Forgoy password"),
      ),
      body: Container(color: Colors.blue.shade50,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Common.custumtextfield(
                fillColor: Colors.white,
                bordercolor: Colors.black,
                text: "Email",
                controller: _emailController),
            const SizedBox(
              height: 30,
            ),
            Common.updateButton(
                text: "Forget Passwords",
                color: Colors.black,
                textcolor: Colors.white,
                onTap: () {
                  _resetPass();
                })
          ],
        ),
      ),
    );
  }

  _resetPass() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailController.text).then((value) => Utils.toastMessage("password send in email "));
  }
}

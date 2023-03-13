import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/logoutscreen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  var receivedID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        color: Colors.blue.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Verification code",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const Text("Otp has been sent your mobile number"),
            const SizedBox(
              height: 20,
            ),
            Common.textField(text: "", fillColor: Colors.blue.shade300),
            const SizedBox(
              height: 20,
            ),
            Common.container(
                text: "Verify now",
                onTap: () {
                  _verifyOTPCode();
                }),
          ],
        ),
      ),
    ));
  }

  _verifyOTPCode() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var shareP = await SharedPreferences.getInstance();

    receivedID = shareP.getString("receive")!;
    var credential = PhoneAuthProvider.credential(
        verificationId: receivedID, smsCode: _otpController.text);

    await auth
        .signInWithCredential(credential)
        .then((value) => print('User Login In Successful'));

    shareP.setBool("login", true);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  LogoutScreen()),
    );
  }
}

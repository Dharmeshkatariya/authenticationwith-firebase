import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/common.dart';
import 'otpscreen.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final _mobileController = TextEditingController();
  final _passController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.deepPurple,
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Common.textField(
                  controller: _mobileController,
                  fillColor: Colors.deepPurple,
                  text: "Phone",
                  prefixIcon: const Icon(
                    Icons.dialer_sip,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Common.container(
                    text: "Sign Up",
                    onTap: () {
                      if (_form.currentState!.validate()) {
                        _mobileVerified();

                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _mobileVerified() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
      phoneNumber: "+91 ${_mobileController.text}",

      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const OtpScreen()),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('TimeOut');
      },
    );
  }
}

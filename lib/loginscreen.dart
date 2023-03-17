import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/signuppage.dart';
import 'package:untitled5/utils/utills.dart';

import 'forgetpassword.dart';
import 'logoutscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _form1 = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.deepPurple,
                )),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70),
                      topLeft: Radius.circular(70),
                    )),
                child: Form(
                  key: _form1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Common.custumtextfield(
                        hintcolor: Colors.white,
                        color: Colors.white,
                        bordercolor: Colors.white,
                        text: "Email",
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                        },
                      ),
                      Common.custumtextfield(
                        hintcolor: Colors.white,
                        color: Colors.white,
                        bordercolor: Colors.white,
                        text: "Password",
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixIcon: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.white,
                        ),
                        controller: _passController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                        },
                      ),
                      Common.container(
                          text: "Login",
                          loading: loading,
                          onTap: () {
                            if (_form1.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              _userLogin();
                            }
                          }),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()),
                          );
                        },
                        child: const Text(
                          "Forget your password?",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignPage()),
                                );
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _userLogin() async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passController.text,
          )
          .then((value) => Utils.toastMessage("login successfully "));
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      var shareP = await SharedPreferences.getInstance();
      shareP.setString("email", _emailController.text);
      shareP.setBool("login", true);
      shareP.setString("pass", _passController.text);
      setState(() {
        loading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LogoutScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/loginscreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen> {

  final _formSignUp = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numerController = TextEditingController();
  final _passController = TextEditingController();
  final _emailController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          children: [
            Container(
              height: 80,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Form(
                  key: _formSignUp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                      ),
                      Common.textField(
                        controller: _nameController,
                        fillColor: Colors.deepPurple,
                        text: "Full Name",
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      Common.textField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                        },
                        controller: _emailController,
                        fillColor: Colors.deepPurple,
                        text: "Email ",
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Common.textField(
                        controller: _numerController,
                        fillColor: Colors.deepPurple,
                        text: "Phone",
                        prefixIcon: const Icon(
                          Icons.dialer_sip,
                          color: Colors.white,
                        ),
                      ),
                      Common.textField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password  is required';
                          }
                        },
                        controller: _passController,
                        fillColor: Colors.deepPurple,
                        text: "Password",
                        suffixIcon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              checkColor: Colors.white,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              }),
                          const Text(
                            "yes agree all Terms & Condition",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Common.container(
                          text: "Sign Up",
                          onTap: () {
                            if (_formSignUp.currentState!.validate()) {
                              _createUser();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                            }
                          }),
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

  _createUser() async {

    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passController.text,
      );
      var shareP = await SharedPreferences.getInstance();
      shareP.setString("email", _emailController.text);
      shareP.setString("pass", _passController.text);

      print(credential.user);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

}

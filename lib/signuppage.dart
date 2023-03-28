import 'package:flutter/material.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/mobileverification.dart';
import 'package:untitled5/signupscreen.dart';

class SignPage extends StatelessWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.deepPurple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Common.container(
                  text: "Sign up with email",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  SignUpScreen()),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              Common.container(
                  text: "Sign up with phone",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  MobileScreen()),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

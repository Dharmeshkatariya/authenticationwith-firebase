import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/controller/signuopscreen_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _signScreenController = Get.put(SignUpScreenController());

  @override
  Widget build(BuildContext context) {
    final formSignUp = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          children: [
            Container(
              height: 40,
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
                  key: formSignUp,
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
                      _textField(
                          text: "full name",
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          controller: _signScreenController.nameController),
                      _textField(
                        text: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                        },
                        controller: _signScreenController.emailController,
                        icon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                      _textField(
                        text: "Phone",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mobile  is required';
                          }
                        },
                        controller: _signScreenController.mobileController,
                        icon: const Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                      ),
                      _textField(
                        suficon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                        text: "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password  is required';
                          }
                        },
                        controller: _signScreenController.passController,
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              checkColor: Colors.white,
                              value: _signScreenController.isChecked.value,
                              onChanged: (bool? value) {
                                _signScreenController.isChecked.value = value!;
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
                          loading: _signScreenController.loading.value,
                          text: "Sign Up",
                          onTap: () {
                            if (formSignUp.currentState!
                                .validate()) {
                              _signScreenController.createUser();
                              _signScreenController.databaseProfile();
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

  Widget _textField(
      {String? text,
      Widget? icon,
      TextEditingController? controller,
      dynamic validator,
      Widget? suficon}) {
    return Common.custumtextfield(
      validator: validator,
      hintcolor: Colors.white,
      color: Colors.white,
      bordercolor: Colors.white,
      controller: controller,
      fillColor: Colors.deepPurple,
      text: text,
      prefixIcon: icon,
      suffixIcon: suficon,
    );
  }
}

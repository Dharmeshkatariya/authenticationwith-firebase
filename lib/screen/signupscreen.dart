import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/controller/signuopscreen_controller.dart';

class SignUpScreen extends GetView<SignUpScreenController> {
  SignUpScreen({Key? key}) : super(key: key);

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
                          controller: controller.nameController),
                      _textField(
                        text: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                        },
                        controller: controller.emailController,
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
                        controller: controller.mobileController,
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
                        controller: controller.passController,
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              checkColor: Colors.white,
                              value: controller.isChecked.value,
                              onChanged: (bool? value) {
                                controller.isChecked.value = value!;
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
                          loading: controller.loading.value,
                          text: "Sign Up",
                          onTap: () {
                            if (formSignUp.currentState!.validate()) {
                              controller.createUser();
                              controller.databaseProfile();
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/controller/loginscreen_controller.dart';
import 'package:untitled5/screen/signuppage.dart';
import 'forgetpassword.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final form1 = GlobalKey<FormState>();
    return Scaffold(
        body: Obx(
      () => Container(
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
                  key: form1,
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
                        controller: controller.emailController,
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
                        controller: controller.passController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                        },
                      ),
                      Common.container(
                          text: "Login",
                          loading: controller.loading.value,
                          onTap: () {
                            if (form1.currentState!.validate()) {
                              controller.loading.value = true;
                              controller.userLogin();
                            }
                          }),
                      GestureDetector(
                        onTap: () {
                          Get.to(ForgotPassword());
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
                                Get.to(SignPage());
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
    ));
  }
}

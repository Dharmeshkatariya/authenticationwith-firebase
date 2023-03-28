import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/routes/name_routes.dart';
import 'package:untitled5/controller/otpscreen_controller.dart';

class OtpScreen extends GetView<OtpScreenController>{
   OtpScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(()=>SafeArea(
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
                Common.custumtextfield(
                    hintcolor: Colors.white,
                    color: Colors.white,
                    bordercolor: Colors.white,
                    controller: controller.otpController,
                    text: "",
                    fillColor: Colors.blue.shade300),
                const SizedBox(
                  height: 20,
                ),
                Common.updateButton(
                    loading: controller.loading.value,
                    color: Colors.orange.shade200,
                    textcolor: Colors.black,
                    text: "Verify now",
                    onTap: () {
                      controller.loading.value = true;
                      controller.verifyOTPCode();
                  Get.toNamed(NameRoutes.chatAppScreen);
                    }),
              ],
            ),
          ),
        ))
    );
  }
}

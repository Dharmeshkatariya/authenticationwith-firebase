import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/chatapp_screen.dart';
import 'package:untitled5/controller/otpscreen_controller.dart';

class OtpScreen extends StatelessWidget{
   OtpScreen({Key? key}) : super(key: key);

  final _otpScreenController = Get.put(OtpScreenController());

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
                    controller: _otpScreenController.otpController,
                    text: "",
                    fillColor: Colors.blue.shade300),
                const SizedBox(
                  height: 20,
                ),
                Common.updateButton(
                    loading: _otpScreenController.loading.value,
                    color: Colors.orange.shade200,
                    textcolor: Colors.black,
                    text: "Verify now",
                    onTap: () {
                      _otpScreenController.loading.value = true;
                      _otpScreenController.verifyOTPCode();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChatAppScreen()),
                      );
                    }),
              ],
            ),
          ),
        ))
    );
  }
}

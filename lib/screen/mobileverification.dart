import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/controller/mobileverification_controller.dart';

class MobileScreen extends GetView<MobileScreenController> {
  MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    return Scaffold(
        body: Obx(
      () => SafeArea(
        child: Container(
          color: Colors.deepPurple,
          child: Form(
            key: form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Common.custumtextfield(
                  bordercolor: Colors.black,
                  color: Colors.white,
                  hintcolor: Colors.white,
                  controller: controller.mobileController,
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
                    loading: controller.loading.value,
                    text: "Sign Up",
                    onTap: () {
                      if (form.currentState!.validate()) {
                        controller.loading.value = true;
                        controller.mobileVerified();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

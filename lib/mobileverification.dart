import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/controller/mobileverification_controller.dart';

class MobileScreen extends StatelessWidget {
  MobileScreen({Key? key}) : super(key: key);

  final _mobileScreenController = Get.put(MobileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => SafeArea(
        child: Container(
          color: Colors.deepPurple,
          child: Form(
            key: _mobileScreenController.form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Common.custumtextfield(
                  bordercolor: Colors.black,
                  color: Colors.white,
                  hintcolor: Colors.white,
                  controller: _mobileScreenController.mobileController,
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
                    loading: _mobileScreenController.loading.value,
                    text: "Sign Up",
                    onTap: () {
                      if (_mobileScreenController.form.currentState!
                          .validate()) {
                        _mobileScreenController.loading.value = true;
                        _mobileScreenController.mobileVerified();
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

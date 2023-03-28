import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/screen/database/Postvisible.dart';
import '../../controller/addfirstore_controller.dart';

class AddFirestoreData extends GetView<AddFireStoreController> {
  AddFirestoreData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          title: const Text("Add post"),
        ),
        body: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            color: Colors.cyan.shade50,
            child: Column(
              children: [
                Common.custumtextfield(
                  bordercolor: Colors.black,
                  text: "Add post",
                  maxline: 4,
                  controller: controller.postController,
                  fillColor: Colors.white,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Common.updateButton(
                      loading: controller.loading.value,
                      onTap: () {
                        controller.loading.value = true;
                        controller.fireStoreData();
                        controller.loading.value = false;
                        Get.to(PostVisibleScreen());
                      },
                      text: "Add Post ",
                      color: Colors.white,
                      textcolor: Colors.black),
                )
              ],
            ),
          ),
        ));
  }
}

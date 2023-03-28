import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/database/Postvisible.dart';
import '../controller/addfirstore_controller.dart';

class AddFirestoreData extends StatelessWidget {
  AddFirestoreData({Key? key}) : super(key: key);

  final _fireStoreController = Get.put(AddFireStoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: const Text("Add post"),
      ),
      body: Obx(()=> Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        color: Colors.cyan.shade50,
        child: Column(
          children: [
            Common.custumtextfield(
              bordercolor: Colors.black,
              text: "Add post",
              maxline: 4,
              controller: _fireStoreController.postController,
              fillColor: Colors.white,
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Common.updateButton(
                  loading: _fireStoreController.loading.value,
                  onTap: () {
                    _fireStoreController.loading.value = true;
                    _fireStoreController.fireStoreData();
                    _fireStoreController.loading.value = false;
                    Get.to(PostVisibleScreen());
                  },
                  text: "Add Post ",
                  color: Colors.white,
                  textcolor: Colors.black),
            )
          ],
        ),
      ),)
    );
  }
}

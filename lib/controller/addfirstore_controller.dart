import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utils/utills.dart';

class AddFireStoreController extends GetxController{
  final postController = TextEditingController();
  RxBool loading = false.obs;
  final fireStore = FirebaseFirestore.instance.collection("Users");


  fireStoreData() {
    try {
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      fireStore
          .doc(id)
          .set({"post": postController.value.text, "id": id}).then((value) => {
        Utils.toastMessage("Post added"),
      });
    } catch (e) {
      print(e);
    }
    loading.value = false;
  }
}
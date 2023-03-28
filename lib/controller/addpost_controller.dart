import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import '../utils/utills.dart';

class AddPostController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final RxList<String> genderItems = [
    'Male',
    'Female',
    "Other",
  ].obs;
  RxString selectedGenderValue = "".obs;
  RxString selectedImage = "".obs;
  RxString imagePath = "".obs;
  RxString genderValue = "".obs;
  RxString updateEmail = "".obs;
  final databaseRef = FirebaseDatabase.instance.ref("User");
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  RxBool loading = false.obs;
  final form = GlobalKey<FormState>();

  @override
  void onInit() {
    if (Get.arguments != null) {
      var userEmail = Get.arguments['path'];
      if (userEmail != null && userEmail.toString().isNotEmpty) {
        _setValue(userEmail);
      }
    }

    super.onInit();
  }

  _setValue(String path) async {
    updateEmail.value = path.toString();
    var arrayEmail = updateEmail.value.split("@");
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('User').child(arrayEmail[0]);
    starCountRef.onValue.listen((DatabaseEvent event) {
      Object? data = event.snapshot.value;
      var user = data! as Map;
      nameController.text = user['fullName'];
      emailController.text = updateEmail.value;
      mobileController.text = user['Mobile'];
      addressController.text = user['address'];
      selectedImage.value = user["userimage"];
      genderValue.value = user["gender"];
    });
  }

  getImageGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imagePath.value = image!.path;
  }

  imageUpdate() async {
    try {
      String storeImage = '';
      var id = DateTime.now().microsecondsSinceEpoch.toString();
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/filename/' "$id");
      firebase_storage.UploadTask uploadTask = ref.putFile(File(
          imagePath.value.isEmpty ? selectedImage.value : imagePath.value));
      await Future.value(uploadTask);
      storeImage = await ref.getDownloadURL();
      loading.value = true;
      String email = emailController.value.text;
      var strEmail = email.split("@");
      databaseRef
          .child(strEmail[0])
          .update({
            "userimage": storeImage,
            "fullName": nameController.value.text,
            "email": emailController.value.text,
            "Mobile": mobileController.value.text,
            "address": addressController.value.text,
            "gender": selectedGenderValue.value,
          })
          .then((value) => Utils.toastMessage("update profile"))
          .onError((error, stackTrace) => Utils.toastMessage(error.toString()));
      loading.value = false;
    } catch (e) {
      print(e);
    }
  }
}

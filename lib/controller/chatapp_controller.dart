import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatAppController extends GetxController{

  RxString email = "".obs ;
  RxString pass  = "".obs ;
  RxString networkImage  = "".obs;
  final searchController = TextEditingController();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final databaseRef = FirebaseDatabase.instance.ref("Profile");
  RxMap<String ,dynamic>? userMap;

  setValue() async {
    var shareP = await SharedPreferences.getInstance();
    email.value = shareP.getString("email")!;
    var arrayEmail = email.value.split("@");
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('User').child(arrayEmail[0]);
    starCountRef.onValue.listen((DatabaseEvent event) {
      Object? data = event.snapshot.value;
      var user = data as Map;
      networkImage.value = user['userimage'];
    });
  }

  onSearch() async {
    await fireStore
        .collection("Profile")
        .where("email", isEqualTo:searchController.value.text)
        .get()
        .then((value) {
      userMap?.value = value.docs[0].data();
      print(userMap);
    });
  }


  signOut() async {
    await FirebaseAuth.instance.signOut();
    var shareP = await SharedPreferences.getInstance();
    shareP.remove("login");
    email.value = shareP.getString("email")!;
    pass.value = shareP.getString("pass")!;
    try {
      User? user = FirebaseAuth.instance.currentUser;
      user?.delete();
      AuthCredential credentials =
      EmailAuthProvider.credential(email: email.value, password:pass.value);
      var result = await user!.reauthenticateWithCredential(credentials);
      DatabaseEventType.childAdded;
      await result.user!.delete();
      return true;
    } catch (e) {
      return null;
    }
  }
}
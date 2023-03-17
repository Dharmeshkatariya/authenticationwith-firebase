import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/utils/utills.dart';
class AddFirestoreData extends StatefulWidget {
  const AddFirestoreData({Key? key}) : super(key: key);

  @override
  State<AddFirestoreData> createState() => _AddFirestoreDataState();
}

class _AddFirestoreDataState extends State<AddFirestoreData> {
  final _postController = TextEditingController();
  bool loading = false;
 final fireStore= FirebaseFirestore.instance.collection("Users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: const Text("Add post"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        color: Colors.cyan.shade50,
        child: Column(
          children: [
            Common.custumtextfield(
              bordercolor: Colors.black,
              text: "Add post",
              maxline: 4,
              controller: _postController,
              fillColor: Colors.white,
            ),
            const SizedBox(
              height: 30,
            ),
            Common.updateButton(
              loading: loading,
              onTap: (){

               setState(() {
                 loading = true;
               });
                _fireStoreData();

              },
                text: "Add Post ",
                color: Colors.blue.shade200,
                textcolor: Colors.black)
          ],
        ),
      ),
    );
  }

  _fireStoreData(){
    try{String id = DateTime.now().microsecondsSinceEpoch.toString();
    fireStore.doc(id).set({
      "post" : _postController.text,
      "id" : id
    }).then((value) => {
      Utils.toastMessage("Post added"),

    });
    }catch(e){
      print(e);
    }
    setState(() {
      loading = false;
    });

  }
}
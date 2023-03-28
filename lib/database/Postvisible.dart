import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostVisibleScreen extends StatefulWidget {
  const PostVisibleScreen({Key? key}) : super(key: key);

  @override
  State<PostVisibleScreen> createState() => _PostVisibleScreenState();
}

class _PostVisibleScreenState extends State<PostVisibleScreen> {
  final fireStore = FirebaseFirestore.instance.collection("Users").snapshots();
  final fireStoreCollection = FirebaseFirestore.instance.collection("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: const Text("Post "),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text("Some error");
                }
                return Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          splashColor: Colors.blue,
                          iconColor: Colors.red,
                          trailing: IconButton(
                              onPressed: () {
                                _snapshotDelete(
                                    snapshot: snapshot, index: index);
                              },
                              icon: const Icon(Icons.delete)),
                          leading: IconButton(
                              onPressed: () {
                                _snapShotUpdate(
                                    snapshot: snapshot, index: index);
                              },
                              icon: const Icon(Icons.more_vert)),
                          title: Text(
                              snapshot.data!.docs[index]["post"].toString()),
                          subtitle:
                              Text(snapshot.data!.docs[index]["id"].toString()),
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }

  _snapShotUpdate(
      {required AsyncSnapshot<QuerySnapshot> snapshot, required int index}) {
    fireStoreCollection
        .doc(snapshot.data!.docs[index]["id"].toString())
        .update({"post": "Dharmesh katariya"});
  }

  _snapshotDelete(
      {required AsyncSnapshot<QuerySnapshot> snapshot, required int index}) {
    fireStoreCollection
        .doc(snapshot.data!.docs[index]["id"].toString())
        .delete();
  }
}

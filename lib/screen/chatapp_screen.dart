import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/controller/chatapp_controller.dart';
import 'package:untitled5/screen/loginscreen.dart';
import 'database/add_firestore_data.dart';
import 'database/add_post.dart';

class ChatAppScreen extends StatefulWidget {
  const ChatAppScreen({Key? key}) : super(key: key);

  @override
  State<ChatAppScreen> createState() => _ChatAppScreenState();
}

class _ChatAppScreenState extends State<ChatAppScreen> {
  final _chatAppController = Get.put(ChatAppController());

  @override
  void initState() {
    // TODO: implement initState
    _chatAppController.setValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {
              Get.to(AddFirestoreData());
              },
              child: const Icon(Icons.add)),
          drawerScrimColor: Colors.white,
          drawer: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  padding: const EdgeInsets.only(
                      top: 40, bottom: 10, right: 10, left: 10),
                  decoration: const BoxDecoration(color: Colors.orange),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _chatAppController.networkImage.value.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: Image.network(
                                _chatAppController.networkImage.value,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FirebaseAnimatedList(
                      query: _chatAppController.databaseRef,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _listTile(
                                  snapshot: snapshot,
                                  path: "fullName",
                                  icon: const Icon(Icons.person)),
                              _listTile(
                                  snapshot: snapshot,
                                  path: "email",
                                  icon: const Icon(Icons.email)),
                              _listTile(
                                  snapshot: snapshot,
                                  path: "Mobile",
                                  icon: const Icon(Icons.call)),
                              _listTile(
                                  snapshot: snapshot,
                                  path: "address",
                                  icon: const Icon(Icons.location_on)),
                              _listTile(
                                  snapshot: snapshot,
                                  path: "gender",
                                  icon: const Icon(Icons.person_pin_rounded)),
                              Common.updateButton(
                                  text: "Edit profile",
                                  color: Colors.black,
                                  onTap: () {
                                    String userEmail = snapshot
                                        .child('email')
                                        .value
                                        .toString();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddPost(
                                                path: userEmail,
                                              )),
                                    );
                                  },
                                  textcolor: Colors.white),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            actions: [
              GestureDetector(
                  onTap: () {
                    _chatAppController.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  LoginScreen()),
                    );
                  },
                  child: const Icon(Icons.logout)),
            ],
            backgroundColor: Colors.orange,
            centerTitle: true,
            title: const Text('chat app'),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Common.custumtextfield(
                    controller: _chatAppController.searchController,
                    text: "Search",
                    prefixIcon: const Icon(Icons.search),
                    bordercolor: Colors.black,
                    fillColor: Colors.white),
                const SizedBox(
                  height: 20,
                ),
                Common.updateButton(
                  onTap: () {
                    _chatAppController.onSearch();
                  },
                  text: "Update",
                  color: Colors.blue.shade300,
                ),
                const SizedBox(
                  height: 20,
                ),
                _chatAppController.userMap != null
                    ? ListTile(
                        title: Text("${_chatAppController.userMap?["email"]}"),
                        subtitle:
                            Text("${_chatAppController.userMap?["Mobile"]}"),
                        leading: const Icon(
                          Icons.account_box,
                          color: Colors.red,
                        ),
                        trailing: const Icon(
                          Icons.chat,
                          color: Colors.red,
                        ))
                    : Container(),
              ],
            ),
          ),
        ));
  }

  Widget _listTile(
      {DataSnapshot? snapshot, required String path, Widget? icon}) {
    return ListTile(
      leading: icon,
      title: Text(" ${snapshot?.child(path).value.toString()}"),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

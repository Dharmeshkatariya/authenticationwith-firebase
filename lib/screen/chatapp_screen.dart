import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/controller/chatapp_controller.dart';
import '../routes/name_routes.dart';

class ChatAppScreen extends GetView<ChatAppController> {
  ChatAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.setValue();
    return Obx(() => Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {
                Get.toNamed(NameRoutes.addFireStoreScreen);
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
                      controller.networkImage.value.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: Image.network(
                                controller.networkImage.value,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FirebaseAnimatedList(
                      query: controller.databaseRef,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _listTile(
                                  snapshot: snapshot,
                                  context: context,
                                  path: "fullName",
                                  icon: const Icon(Icons.person)),
                              _listTile(
                                  snapshot: snapshot,
                                  context: context,
                                  path: "email",
                                  icon: const Icon(Icons.email)),
                              _listTile(
                                  snapshot: snapshot,
                                  context: context,
                                  path: "Mobile",
                                  icon: const Icon(Icons.call)),
                              _listTile(
                                  snapshot: snapshot,
                                  context: context,
                                  path: "address",
                                  icon: const Icon(Icons.location_on)),
                              _listTile(
                                  snapshot: snapshot,
                                  path: "gender",
                                  context: context,
                                  icon: const Icon(Icons.person_pin_rounded)),
                              Common.updateButton(
                                  text: "Edit profile",
                                  color: Colors.black,
                                  onTap: () {
                                    String userEmail = snapshot
                                        .child('email')
                                        .value
                                        .toString();
                                    Get.toNamed(
                                      NameRoutes.addPostScreen,
                                      arguments: {'path': userEmail},
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
                    controller.signOut();
                    Get.toNamed(NameRoutes.logInScreen);
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
                    controller: controller.searchController,
                    text: "Search",
                    prefixIcon: const Icon(Icons.search),
                    bordercolor: Colors.black,
                    fillColor: Colors.white),
                const SizedBox(
                  height: 20,
                ),
                Common.updateButton(
                  onTap: () {
                    controller.onSearch();
                  },
                  text: "Update",
                  color: Colors.blue.shade300,
                ),
                const SizedBox(
                  height: 20,
                ),
                controller.userMap != null
                    ? ListTile(
                        title: Text("${controller.userMap?["email"]}"),
                        subtitle: Text("${controller.userMap?["Mobile"]}"),
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
      {DataSnapshot? snapshot,
      required String path,
      Widget? icon,
      required BuildContext context}) {
    return ListTile(
      leading: icon,
      title: Text(" ${snapshot?.child(path).value.toString()}"),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

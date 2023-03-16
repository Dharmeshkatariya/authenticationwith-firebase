import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/loginscreen.dart';

import 'database/add_post.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  var email = "";
  var pass = "";
  String networkImage = "";
  final databaseRef = FirebaseDatabase.instance.ref("Post");

  @override
  void initState() {
    // TODO: implement initState
    _setValue();
    super.initState();
  }

  _setValue() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('Post').child('Profile');
    starCountRef.onValue.listen((DatabaseEvent event) {
      Object? data = event.snapshot.value;
      var user = data! as Map;
      networkImage = user['userimage'];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.only(top: 40,bottom: 10,right: 10,left: 10),
              decoration: const BoxDecoration(color: Colors.orange),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  networkImage.isNotEmpty?
                  ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: Image.network(
                      networkImage,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ) : Container(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddPost()),
                      );
                    },
                    child: const Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  query: databaseRef,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddPost()),
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
                _signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Icon(Icons.logout)),
        ],
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text('Logout Screen'),
      ),
      body: Container(),
    );
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

  _signOut() async {
    await FirebaseAuth.instance.signOut();
    var shareP = await SharedPreferences.getInstance();
    shareP.remove("login");
    email = shareP.getString("email")!;
    pass = shareP.getString("pass")!;
    try {
      User? user = FirebaseAuth.instance.currentUser;
      user?.delete();
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: pass);
      var result = await user!.reauthenticateWithCredential(credentials);
      DatabaseEventType.childAdded;
      await result.user!.delete();
      return true;
    } catch (e) {
      return null;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
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
  final databaseRef = FirebaseDatabase.instance.ref("Post");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.only(top: 40),
              decoration: const BoxDecoration(color: Colors.orange),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      "assets/images/b.jpg",
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
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
                          Common.updateButton(
                              text: "Edit profile",
                              color: Colors.black,
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AddPost()),
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
      body: Container(
        child: Column(
          children: [],
        ),
      ),
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
      print(user);
      var result = await user!.reauthenticateWithCredential(credentials);
      await DatabaseEventType.childAdded;
      await result.user!.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

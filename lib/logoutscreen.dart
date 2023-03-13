import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/loginscreen.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:  [
          GestureDetector(
            onTap: (){
             _signOut();
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => const LoginScreen()),
             );
            },
              child: const Icon(Icons.logout)),
        ],
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Logout Screen'),
      ),
      body: const Center(
        child:  Text(
          "Welcome to Yoga Fit app ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.black87),
        ),
      ),
    );
  }
  _signOut()async{

    await FirebaseAuth.instance.signOut();
    var shareP = await SharedPreferences.getInstance();
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('The user must reauthenticate before this operation can be executed.');
      }
    }
 
     shareP.remove("login");
  }
}

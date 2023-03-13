import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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

  var email = "";
  var pass = "";
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
     shareP.remove("login");
     email = shareP.getString("email")!;
     pass = shareP.getString("pass")!;
    try {
      User? user = FirebaseAuth.instance.currentUser;
      user?.delete();
      AuthCredential credentials = EmailAuthProvider.credential(email: email, password: pass);
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


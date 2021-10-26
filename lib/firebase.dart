import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TestApp.dart';
import 'main.dart';
import 'TestAppState.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterFireAuthService  {
  final FirebaseAuth _firebaseAuth;
  FlutterFireAuthService(this._firebaseAuth) ;

  Stream<User?>get authStateChanges => _firebaseAuth.idTokenChanges();
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();

  }

  Future<String?> signIn (
      {required String email, required String password, required BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      //print("Signed In");
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/profile', (Route<dynamic> route) => false);

      // Navigator.pushAndRemoveUntil<void>(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => TestApp(),
      //   ),
      //     //ModalRoute.withName('/profile'),
      //         (_) => false
      // );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Username or Pasword entered is invalid",backgroundColor: Colors.blue);
      return e.message;
    }
  }

  Future<String?> signUp(
      {required String email, required String password, required BuildContext context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestApp(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Username or Password entered is invalid",backgroundColor: Colors.blue);
      return e.message;
    }
  }
}





// import 'home.dart'
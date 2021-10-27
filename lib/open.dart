import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';

import 'login.dart';
import 'sign_in.dart';
import 'package:jarvia/TestApp.dart';
import 'main.dart';
import 'firebase.dart';

import 'package:jarvia/TestAppState.dart';


class OpenView extends StatefulWidget{
  OpenView({Key? key}):super(key: key);
  @override
  _OpenViewState createState() => _OpenViewState();
}

class _OpenViewState extends State<OpenView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final firebaseUser =  context.watch<User?>();
    if (firebaseUser!=null) {
      print("Home View");
      return TestApp();
    }
    print ("NOt Authenticated");

    return Scaffold(
      body: Container(



          child:Column(

            children: [

              SizedBox(height: 100,),
             Center(

               child: Text('Proda',style: TextStyle(fontSize: 70),), ),
              SizedBox(height: 120,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  textStyle:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              onPressed:(){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>Login())

                );
              },
              child: Text("Login"),

            ),
            SizedBox(height: 15,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
                  textStyle:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              onPressed:(){

                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>Sign_in())

                );
              },
              child: Text("Sign up"),

            ),



          ],)



      ),
    );
  }
}
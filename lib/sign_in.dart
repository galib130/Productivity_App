import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'firebase.dart';
class Sign_in extends StatefulWidget{
  const Sign_in({Key? key}):super(key: key);
  @override
  _Sign_in_state createState()=>_Sign_in_state();
}


class _Sign_in_state extends State<Sign_in>{
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Sign up to Productivity App')
        ),
        body: Form(

          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText:'Email'
                ),

              ),
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
              labelText:'Password'
          ),
          obscureText: true,
        )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: (){
          context.read<FlutterFireAuthService>().signUp(email: emailController.text.trim(), password: passwordController.text.trim()
              , context: context);

          },
        ),

      ),


    );
  }

}
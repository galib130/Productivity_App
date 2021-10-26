import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'firebase.dart';
class Login extends StatefulWidget{
  const Login({ Key? key}):super(key: key);
  @override
  _Login_state createState()=>_Login_state();
}


class _Login_state extends State<Login>{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Jarvia log in')
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
          context.read<FlutterFireAuthService>().signIn(email: emailController.text.trim(),
              password: passwordController.text.trim(),
              context: context);
          },
        ),

      ),


    );
  }

}
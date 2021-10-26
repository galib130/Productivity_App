

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';




class AddList_State  extends StatelessWidget{
  bool _value = false;
  List Textadd ;
  Future<void>Function(String) ondismissed;
  Function(String,bool,DocumentSnapshot) checkbox;
  Future<void> Function(String,String) update;
  Stream<DocumentSnapshot> firebaselist;
  Stream<QuerySnapshot>firebasequery;


    createAlertDialog(BuildContext, context, String data,DocumentSnapshot document){
      TextEditingController update_controller=  TextEditingController();
      update_controller.text=data;
      return showDialog(context: context, builder: (context){
        return AlertDialog(
            title: Text("new"),
          content:
          Container(

            height: 100,
            child:Column(

              children: [
                TextField(
                  controller: update_controller,
                ),
                ElevatedButton(onPressed: (){
                  //update(update_controller.text,data);
                  document.reference.update({"Name": update_controller.text,"displayName":update_controller.text});

                  Navigator.pop(context);
                },child: Text('Edit'),),
              ],
            ) ,
          )

        );
      });
    }
   int flag;
  AddList_State({required this.Textadd,  required this.ondismissed,required this.firebaselist,required this.firebasequery,required this.flag,
  required this.checkbox,required this.update,
  });
  List list1=[''];
  Widget build(BuildContext context){
    return
      Expanded(

        child: StreamBuilder<QuerySnapshot>(
        stream: firebasequery,          //.doc('itemvalue').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<dynamic, dynamic> data = document.data()! as Map<dynamic, dynamic>;
            return Dismissible(key: UniqueKey(),
                onDismissed:(DismissDirection){
                  //ondismissed(data['Name']);
                  document.reference.delete();
                  },
                child: GestureDetector(
                  onLongPress: (){

                createAlertDialog(BuildContext, context,data['Name'].toString(),document);
                },
                  child:
                      ListTile(
                        title: Container(child:Column(
                           
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                             Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Expanded(
                                     child: Text(data['displayName'].toString(),style:
                                 new TextStyle(
                                     fontSize: 24
                                 ),),
                                   ),
                                   Checkbox(
                                   autofocus: true,
                                       value: data['ticked'],
                                       onChanged: (bool? value){
                                     checkbox(data['Name'],value!,document);
                                   }),
                                 ]),
                           if(data.containsValue(data['setTime']))
                           Text(data['setTime'].toString(),style:
                             TextStyle(fontStyle: FontStyle.italic),)
                            ])
                           ,),
                          tileColor: Colors.lightBlue,),
                )
            );
          }).toList(),
          );}
          ),
      );
  }}





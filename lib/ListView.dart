import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jarvia/main.dart';

class AddList_State  extends StatelessWidget{
  bool _value = false;


  Function(String,bool,DocumentSnapshot) checkbox;
  Function  set_date;
  Function  set_time;
  TextEditingController date_controller;
  TextEditingController time_controller;
  MaterialColor color;

  Stream<QuerySnapshot>firebasequery;



    createAlertDialog(BuildContext, context, String data,DocumentSnapshot document,String description,Map<dynamic, dynamic> map_data,
        TextEditingController date_controller,TextEditingController time_controller
        ){
      TextEditingController update_controller=  TextEditingController();
      TextEditingController description_controller=  TextEditingController();
      TextEditingController date_controller_proxy=  TextEditingController();
      date_controller_proxy=date_controller;
      TextEditingController time_controller_proxy=  TextEditingController();
      time_controller_proxy=time_controller;
      update_controller.text=data;
      description_controller.text=description;
      if(map_data.containsValue(map_data['date']))
      date_controller.text=map_data['date'];
      if(map_data.containsValue(map_data['time']))
        time_controller.text=map_data['time'];
      return showDialog(context: context, builder: (context){
        return AlertDialog(
          backgroundColor: Colors.cyan,
            title: Text("Details"),
          content:
          Container(

            height: 500,
            width: 550,
            child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Task'),
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    controller: update_controller,

                  ),
                ),
                Text('Description'),

                Expanded(
                  child: TextField(
                    maxLines: 1,
                    controller: description_controller,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                        hintText: 'Date'
                    ),
                    controller: date_controller,

                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    set_date(context);
                  },
                  child: Text('Select Date'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),


                Expanded(
                  flex: 1,
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                        hintText: 'Time'
                    ),
                    controller: time_controller,

                  ),
                ),
                ElevatedButton(
                  child: Text('Select Time'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  onPressed:(){
                    set_time(context);
                  },),
                ElevatedButton(onPressed: (){
                  //update(update_controller.text,data);
                  document.reference.update({"Name": update_controller.text,"displayName":update_controller.text,
                    "description":description_controller.text,"time":time_controller.text,"date":date_controller.text,
                    "setTime": date_controller.text + '  '+ time_controller.text
                  });
                  date_controller.clear();
                  time_controller.clear();
                  Navigator.pop(context);
                },child: Text('Edit'),),
              ],
            ) ,
          )

        );
      });
    }
   int flag;
  AddList_State({required this.firebasequery,required this.flag,
  required this.checkbox,required this.set_date,required this.set_time,required this.date_controller,required this.time_controller,
    required this.color
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
            shrinkWrap: true,

            children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<dynamic, dynamic> data = document.data()! as Map<dynamic, dynamic>;
            return Dismissible(key: UniqueKey(),
                onDismissed:(DismissDirection)async{
                  //ondismissed(data['Name']);
                  await flutterLocalNotificationsPlugin.cancel(data['notification id'].hashCode);
                  document.reference.delete();
                  },
                child: GestureDetector(
                  onLongPress: (){
              if(data.containsValue(data['description']))
                createAlertDialog(BuildContext, context,data['displayName'].toString(),document,data['description'],
                  data,date_controller,time_controller,

                );
              else
                createAlertDialog(BuildContext, context,data['displayName'].toString(),document,'',data,date_controller,time_controller,);

                  },
                  child:
                      Column(
                        children: [
                          Container(

                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(5),
                                image:  DecorationImage(image: new AssetImage('assets/listtile.jpg'),fit: BoxFit.cover)
                            ),
                            child: Column(
                              children: [
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
                                                 fontSize: 20
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

                                    ),

                              ],
                            ),
                          ),
                          SizedBox(height: 5,)
                        ],
                      ),

                )
            );
          }).toList(),
          );}
          ),
      );
  }}





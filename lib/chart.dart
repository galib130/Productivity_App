import 'dart:ffi';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'TestAppState.dart';
class Session_Object{
  final int value;
  final String xaxis;
  final String color;
   final String time ;
  Session_Object({required this.value,required this.xaxis, required this.color,required this.time});
 Session_Object.fromMap(Map<String,dynamic>map,)
      :assert(map['Name']!=null),
      assert(map['xaxis']!=null),
      assert(map['color']!=null),
      assert(map['time']!=null),

  value=map['Name'],
  xaxis=map['xaxis'],
  color=map['color'],
  time=map['time'];



@override
  String toString()=>"R";
}

FirebaseAuth auth= FirebaseAuth.instance;

class Session extends StatefulWidget{

    _SessionState createState()=> _SessionState();

}


class _SessionState extends State<Session> {
   List<charts.Series<Session_Object, String>> _seriesBarData=[];
   String uid =auth.currentUser!.uid;
    Timestamp session_timestamp =  Timestamp.now();
   List<Session_Object>mydata=[];
   DateTime session_day=DateTime.now();

  _generatechart(mydata) {
    _seriesBarData.add(
        charts.Series(
            domainFn: (Session_Object session_axis, _) =>
                session_axis.xaxis.toString(),
            measureFn: (Session_Object session_axis, _) => session_axis.value,
            colorFn: (Session_Object session_axis, _) =>
                charts.ColorUtil.fromDartColor(
                  Color(int.parse(session_axis.color)),),
            data: mydata,
            id: 'Session'

        )
    );
  }
  TextEditingController textedit= new TextEditingController();



   @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(appBar: AppBar(title: Text('Session Summary' ),),
      body: _buildbody(context),);
  }


  Widget _buildbody(context) {
    String uid = auth.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Users")
            .doc(uid)
            .collection("session")
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
          return Text('Nothing to show');
          }
          else if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          else {
            List<Session_Object> session = snapshot.data!.docs.map((
                DocumentSnapshot snapshot) =>
                Session_Object.fromMap(snapshot.data() as Map<String, dynamic>))
                .toList();

            return _buildChart(context, session);
          }


        }

    );
  }

  Widget _buildChart(BuildContext context, List<Session_Object> session, ) {
    mydata = session;
    _generatechart(mydata);




      //print(get_last_sesion_date);

    return Padding(padding: EdgeInsets.all(5.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[

            if(session.isNotEmpty)
              Text('Session ends at :  '+session[1].time),

          Row(

            children: [
              RaisedButton(onPressed: (){

                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/profile', (Route<dynamic> route) => false);

              },child: Text('Add'),
              ),
              RaisedButton(onPressed: (){

                Navigator.of(context)
                    .pushNamed('/average_chart');

              },child: Text('Efficiency'),
              ),



            ],
          ),


           SizedBox(height: 5.0,),
              Expanded(
                  child:charts.BarChart(_seriesBarData,
                      animate: true,
                    animationDuration: Duration(seconds: 3),


                  )


              ),
            ],

          ),
        ),
      ),

    );
  }

  }


import 'dart:ffi';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'TestAppState.dart';
class Average_Session_Object{
  final int value;
  final String xaxis;
  final String color;
  final String session;

  Average_Session_Object({required this.value,required this.xaxis, required this.color,required this.session});
  Average_Session_Object.fromMap(Map<String,dynamic>map,)
      :assert(map['Name']!=null),
        assert(map['xaxis']!=null),
        assert(map['color']!=null),
        assert(map['session']!=null),


        value=map['Name'],
        xaxis=map['xaxis'],
        color=map['color'],
        session=map['session'].toString();




  @override
  String toString()=>"R";
}

FirebaseAuth auth= FirebaseAuth.instance;

class Average_Session extends StatefulWidget{

  _Average_SessionState createState()=> _Average_SessionState();

}


class _Average_SessionState extends State<Average_Session> {
  List<charts.Series<Average_Session_Object, String>> _seriesBarData=[];
  String uid =auth.currentUser!.uid;
  Timestamp session_timestamp =  Timestamp.now();
  List<Average_Session_Object>mydata=[];
  DateTime session_day=DateTime.now();

  _average_generatechart(mydata) {
    _seriesBarData.add(
        charts.Series(
            domainFn: (Average_Session_Object session_axis, _) =>
                session_axis.xaxis.toString(),
            measureFn: (Average_Session_Object session_axis, _) => session_axis.value/int.parse(session_axis.session),
            colorFn: (Average_Session_Object session_axis, _) =>
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


    return Scaffold(appBar: AppBar(title: Text('Efficiency of Quadrants' ),),
      body: _average_buildbody(context),);
  }


  Widget _average_buildbody(context) {
    String uid = auth.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Users")
            .doc(uid)
            .collection("average_session")
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Text('Nothing to show');
          }
          else if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          else {
            List<Average_Session_Object> session = snapshot.data!.docs.map((
                DocumentSnapshot snapshot) =>
                Average_Session_Object.fromMap(snapshot.data() as Map<String, dynamic>))
                .toList();

            return _average_buildChart(context, session);
          }


        }

    );
  }

  Widget _average_buildChart(BuildContext context, List<Average_Session_Object> session, ) {
    mydata = session;
    _average_generatechart(mydata);




    //print(get_last_sesion_date);

    return Padding(padding: EdgeInsets.all(5.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              if(session.isNotEmpty)
                Text('No. of session : '+ session[1].session.toString()),


             Row(children: [
               RaisedButton(onPressed: (){

                 Navigator.of(context)
                     .pushNamedAndRemoveUntil('/profile', (Route<dynamic> route) => false);

               },child: Text('Add'),),
               RaisedButton(onPressed: (){

                 Navigator.of(context)
                     .pushNamedAndRemoveUntil('/chart', (Route<dynamic> route) => false);

               },child: Text('Session Summary'),),

             ],),

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


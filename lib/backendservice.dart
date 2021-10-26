import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
FirebaseAuth auth= FirebaseAuth.instance;
String uid =auth.currentUser!.uid;

class BackendService{
  List<dynamic> suggestList=[];
  Future<List> getSuggestions(String query) async {

    var tasklist = FirebaseFirestore.instance.collection('Users').doc(uid).collection('Quadrant1_Complete');

    tasklist.get().then((snapshot){
      snapshot.docs.forEach((doc) {
        suggestList.add(doc.id);
        // print(doc.id);
      });
    });



    return suggestList;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'TestAppState.dart';
createAlertDialog(BuildContext context,TextEditingController  _namecontroller,TextEditingController _datecontroller,
    TextEditingController _timecontroller,TextEditingController _descriptioncontroller, Function _selectDate,Function _selectTime,
    ){

  return showDialog(context: context, builder: (context){
    return AlertDialog(

        title: Text("Details"),
      backgroundColor: Colors.cyan,
        content:
        Container(
          height: 450,

          child:Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1 ,
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Task'
                  ),
                  controller: _namecontroller,

                ),
              ),
              Expanded(
                flex: 1 ,

                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Description'
                  ),
                  controller:_descriptioncontroller,

                ),
              ),





                  Expanded(
                    flex: 1,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Date'
                      ),
                      controller: _datecontroller,

                    ),
                  ),
              ElevatedButton(
                onPressed: (){
                  _selectDate(context);
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
                      decoration: InputDecoration(
                          hintText: 'Time'
                      ),
                      controller: _timecontroller,

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
                  _selectTime(context);
                },),




                  //Button to select time







              ElevatedButton(onPressed: (){
                //update(update_controller.text,data);


                Navigator.pop(context);
              },child: Text('Done'),),
            ],
          ) ,
        )

    );
  });
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class Get extends StatefulWidget{
  @override
  State<Get> createState() => _GetState();
}

class _GetState extends State<Get> {
  double before_y = 0;

  double current_y = 0;
  
  @override
  void initState(){
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        before_y = current_y;
        current_y = event.y;
        print('before_y: $before_y');
        print('current_y: $current_y');
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Get"),
      ),
      body: Column(
        children: <Widget>[
          if(before_y < 0 && current_y > 0)
            Text('Get!!'),
        ],
      ),
    );
  }
}
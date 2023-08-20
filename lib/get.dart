import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app.dart';
import 'package:flutter_application_2/scoop.dart';
import 'package:sensors/sensors.dart';

class Get extends StatefulWidget {
  @override
  State<Get> createState() => _GetState();
}

class _GetState extends State<Get> {
  double before_y = 0;

  double current_y = 0;

  @override
  void initState() {
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
  Widget build(BuildContext context) {
    return Center(
      child: ifWidget(true),
    );
    // return Scaffold(
    // body: ,
    // appBar: AppBar(
    //   title: Text("Get"),
    // ),
    // body: Column(
    //   children: <Widget>[
    //     // if (before_y < 0 && current_y > 0) Text('Get!!'),
    //     if (before_y >= -8 && before_y <= -3)
    //       if (current_y >= 5 && current_y <= 8)
    //         Navigator.push(context,MaterialPageRoute(builder: (context) => Scoop())),
    //   ],
    // );
  }

  Widget ifWidget(bool T) {
    if (T) {
      return const MyApp();
    } else {
      return const Scoop();
    }
  }
}

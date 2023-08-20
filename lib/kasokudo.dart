import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class PointerMovementPage extends StatefulWidget {
  @override
  _PointerMovementPageState createState() => _PointerMovementPageState();
}

class _PointerMovementPageState extends State<PointerMovementPage> {
  double x = 0;
  double y = 0;
  double z = 0;
  double? _deviceWidth, _deviceHeight;
  double? _circle_x, _circle_y;

  @override
  void initState() {
    super.initState();

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x -= event.x*8;
        y -= event.y*8;
        z -= event.z;
        print(event.y);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _circle_x = MediaQuery.of(context).size.width / 2;
    _circle_y = MediaQuery.of(context).size.height / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Accelerometer Pointer Movement"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: _circle_x = _circle_x! + x,
            top: _circle_y = _circle_y! - y,
            child: Icon(Icons.circle, size: 50.0),
          ),
        ],
      ),
    );
  }
}
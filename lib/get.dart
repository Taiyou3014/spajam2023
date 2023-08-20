import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'ans.dart';

class Get extends StatefulWidget {
  final String path; // 引数として受け取る
  final String name;
  final String ans;

  Get({required this.path, required this.name, required this.ans});
  @override
  State<Get> createState() => _GetState(path: path, name: name, ans: ans);
}

class _GetState extends State<Get> {
  final String path;
  final String name;
  final String ans;
  double before_y = 0;
  double current_y = 0;
  _GetState({required this.path, required this.name, required this.ans});
  bool flag = false;

  void _navigateToOtherScreen() {
    // 変数の値に基づいて画面遷移を実行するメソッ
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MoneyAnimation(flag: flag)));
  }

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

  Widget ifWidget(_size) {
    if (before_y < 0 && current_y > 0) {
      _navigateToOtherScreen();
      return MaterialApp(home: MoneyAnimation(flag: flag));
    } else {
      return Container(
        color: Color.fromARGB(255, 165, 252, 226),
        child: Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(height: _size.height * 0.25),
              Image.asset('assets/images/hit.png'),
              SizedBox(
                width: 200,
                height: 70,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(path),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    if (ans == name)
      flag = true;
    else
      flag = false;

    return ifWidget(_size);
    /*return Container(
      color: Color.fromARGB(255, 165, 252, 226),
      child: Expanded(
        child: Column(
          children: <Widget>[
            SizedBox(height: _size.height * 0.25),
            Image.asset('assets/images/hit.png'),
            SizedBox(
              width: 200,
              height: 70,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(path),
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      decoration: TextDecoration.none),
                ),
              ],
            ),
            if (before_y < 0 && current_y > 0)
              Column(
                  _navigateToOtherScreen()),
              
              /*GestureDetector(Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MoneyAnimation(flag: flag)))),
          */
          ],
        ),
      ),
    );
  */
  }
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'ans.dart';
import 'scoop.dart';

class Get extends StatefulWidget {
  final String path; // 引数として受け取る
  final String name;
  final String ans;

  Get({required this.path, required this.name, required this.ans});
  @override
  State<Get> createState() => _GetState(path: path, name: name, ans: ans);
}

class _GetState extends State<Get> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Money> moneyList = [];
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
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _controller.addListener(() {
      setState(() {
        moneyList.forEach((money) {
          money.updatePosition();
        });
      });
    });

    _controller.repeat();

    // 初期のお金の位置を設定
    for (int i = 0; i < 50; i++) {
      moneyList.add(Money(
        position: Offset(
          Random().nextDouble() * 400, // ランダムなx位置
          Random().nextDouble() * -600, // 画面上部から出発
        ),
      ));
    }

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        before_y = current_y;
        current_y = event.y;
        print('before_y: $before_y');
        print('current_y: $current_y');
      });
    });
  }

  bool a = false;
  Widget ifWidget(_size) {
    if (before_y < 0 && current_y > 0) {
      a = true;
    }
    //_navigateToOtherScreen();
    if (a) {
      //return MaterialApp(home: MoneyAnimation(flag: flag));
      return Container(
        color: Colors.teal[200],
        child: Stack(
          children: [
            if (flag == true)
              for (var money in moneyList)
                Positioned(
                  left: money.position.dx,
                  top: money.position.dy,
                  child: Transform.rotate(
                    angle: money.rotation,
                    child: Icon(
                      Icons.attach_money,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
                ),
            if (flag == false)
              for (var money in moneyList)
                Positioned(
                  left: money.position.dx,
                  top: money.position.dy,
                  child: Transform.rotate(
                    angle: money.rotation,
                    child: Icon(
                      Icons.attach_money,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                ),
            Container(
              width: _size.width,
              height: _size.height * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8.0),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: _size.height * 0.25),
                    if (flag == true)
                      Image.asset(
                        'assets/images/seikai.png', // 画像ファイルのパスを指定
                        height: 200, // 画像の高さを指定
                      ),
                    if (flag == true) SizedBox(height: 10),
                    if (flag == false)
                      Image.asset(
                        'assets/images/fuseikai.png', // 画像ファイルのパスを指定
                        height: 200, // 画像の高さを指定
                      ),
                    if (flag == false) SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        //Navigator.pop(context); // ダイアログを閉じる
                        //Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Scoop()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // ボタンの背景色を青色に設定
                        foregroundColor: Colors.white, // テキストの色を白色に設定
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text("閉じる"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
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

class Money {
  Offset position;
  double rotation;

  Money({required this.position, this.rotation = 0.0});

  void updatePosition() {
    if (position.dy > 800) {
      position = Offset(
        Random().nextDouble() * 400,
        -24,
      );
    } else {
      position = Offset(position.dx, position.dy + 2);
    }
    rotation += 0.1; // 回転を増やすことでアイコンが揺れるようにする
  }
}

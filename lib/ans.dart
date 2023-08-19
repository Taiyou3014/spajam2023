import 'dart:math';
import 'package:flutter/material.dart';

class MoneyAnimation extends StatefulWidget {
  final bool flag; // 引数として受け取る
  MoneyAnimation({required this.flag});

  @override
  _MoneyAnimationState createState() => _MoneyAnimationState(flag: flag);
}

class _MoneyAnimationState extends State<MoneyAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Money> moneyList = [];
  final bool flag; // 引数をインスタンス変数として持つ

  _MoneyAnimationState({required this.flag}); // コンストラクタ
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
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
                  if (flag == true)
                    /*Text(
                      "正解!\nあなたは地方を救いました!",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          decoration: TextDecoration.none),
                    ),*/
                    SizedBox(height: 10),
                  if (flag == false)
                    Image.asset(
                      'assets/images/fuseikai.png', // 画像ファイルのパスを指定
                      height: 200, // 画像の高さを指定
                    ),
                  if (flag == false)
                    /*Text(
                      "不正解!\n財政破綻!!",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          decoration: TextDecoration.none),
                    ),*/
                    SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // ダイアログを閉じる
                      Navigator.pop(context);
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

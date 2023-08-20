import 'package:flutter/material.dart';
import 'package:flutter_application_2/make_question.dart';
import 'package:sensors/sensors.dart';
import 'ans.dart';
import 'dart:math';
import 'prefecture.dart';
import 'get.dart';

// Scoop(掬う) 都道府県を掬う画面
class Scoop extends StatefulWidget {
  const Scoop({Key? key}) : super(key: key);

  @override
  State<Scoop> createState() => _ScoopState();
}

class _ScoopState extends State<Scoop> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Tween<double> positionedTween;
  late Tween<double> rotateTween; // <<< 2つ目のアニメーションのTween
  late Animation<double> rotateAnimation; // <<< 2つ目のアニメーション
  late Animation<double> positionedAnimation;

  final Prefecture_width = 150.0;
  final Prefecture_hight = 150.0;

  var prefecture_list = _shuffle([0, 1, 2, 3, 4]);
  late Future<String> question;

  double x = 0;
  double y = 0;
  double z = 0;
  double? _deviceWidth, _deviceHeight;
  double? _circle_x, _circle_y;

  bool hit = false;
  var encount_num = 0;

  List<Prefecture> imageWidgets = [
    Prefecture(image_path: 'assets/images/prefectures/fukuoka.png', name: '福岡'),
    Prefecture(
        image_path: 'assets/images/prefectures/kagoshima.png', name: '鹿児島'),
    Prefecture(
        image_path: 'assets/images/prefectures/kumamoto.png', name: '熊本'),
    Prefecture(
        image_path: 'assets/images/prefectures/miyazaki.png', name: '宮崎'),
    Prefecture(
        image_path: 'assets/images/prefectures/nagasaki.png', name: '長崎'),
  ];

  @override
  void initState() {
    var num_ans = _shuffle([0, 1, 2])[0];
    super.initState();
    question = makeQuestion(imageWidgets[num_ans].name);

    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    rotateTween =
        Tween(begin: -0.1 * pi, end: 0.1 * pi); // <<< 回転のアニメーションの始点と終点を定義
    positionedTween = Tween(begin: -20, end: 20.0);
    rotateAnimation = controller.drive(rotateTween); // <<< 回転のアニメーションを生成
    positionedAnimation = controller.drive(positionedTween);
    super.initState();
    controller.forward();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x -= event.x * 8;
        y -= event.y * 8;
        z -= event.z;
        // print(event.y);
      });
    });
    if (_circle_x != null && _circle_y != null) {
      if (_circle_x! > 155 &&
          _circle_x! < 195 &&
          _circle_y! > 130 &&
          _circle_y! < 170) {
        hit = true;
      } else if (_circle_x! > 305 &&
          _circle_x! < 345 &&
          _circle_y! > 255 &&
          _circle_y! < 295) {
        hit = true;
      } else if (_circle_x! > 555 &&
          _circle_x! < 595 &&
          _circle_y! > 155 &&
          _circle_y! < 195) {
        hit = true;
      }
    }
    print(_circle_x);
  }

  // void circleCenter(){
  //   setState(() {
  //     _circle_x! + x;
  //     _circle_y! - y;
  //     print(_circle_x);
  //   });
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _circle_x = MediaQuery.of(context).size.width / 2 + x + 25;
    _circle_y = MediaQuery.of(context).size.height / 2 - y + 25;
    if (_circle_y! > 155 &&
        _circle_y! < 195 &&
        _circle_x! > 130 &&
        _circle_x! < 170) {
      hit = true;
      encount_num = 0;
    } else if (_circle_y! > 305 &&
        _circle_y! < 345 &&
        _circle_x! > 255 &&
        _circle_x! < 295) {
      hit = true;
      encount_num = 1;
    } else if (_circle_y! > 555 &&
        _circle_y! < 595 &&
        _circle_x! > 155 &&
        _circle_x! < 195) {
      hit = true;
      encount_num = 2;
    }
    print(_circle_x);
    if (!hit) {
      return Scaffold(
        appBar: AppBar(title: const Text("Scoop")),
        body: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Stack(
              children: <Widget>[
                Image.asset(
                  'assets/images/water.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                FutureBuilder<String>(
                  future: question,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      // テキストの位置とスタイルを変更
                      return Positioned(
                        top: MediaQuery.of(context).size.height *
                            0.1, // 画面の上部1/20の位置に配置
                        left: 20.0, // テキストの左側の余白を20.0に設定
                        right: 20.0, // テキストの右側の余白を20.0に設定

                        child: Column(
                          children: [
                            // ここに新しく追加するテキスト
                            Text(
                              'この都道府県にポインタを合わせろ！',
                              style: TextStyle(
                                fontSize: 30.0, // 任意のサイズに調整可能
                                fontWeight: FontWeight.w600, // 任意の太さに調整可能
                                color: Colors.black, // 色は赤に設定（任意の色に調整可能）
                                // fontFamily: 'あなたの希望のフォント名', // 必要に応じてフォントを設定
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10.0), // この部分でテキスト間のスペースを調整
                            Container(
                              padding: EdgeInsets.all(10.0),
                              color: Colors.white,
                              child: Text(
                                snapshot.data!,
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 7, 82, 144),
                                  fontFamily: 'azuki',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                          child:
                              const CircularProgressIndicator()); // or another widget to show loading
                    }
                  },
                ),

                // 1つ目の県
                Positioned(
                  top: 500.0,
                  left: 50.0 + positionedAnimation.value,
                  width: Prefecture_width,
                  height: Prefecture_hight,
                  child: Transform.rotate(
                    angle: rotateAnimation.value, // <<< 回転のアニメーション変化を適用
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          imageWidgets[prefecture_list[0]].image_path,
                          fit: BoxFit.cover,
                        ),
                        Text(imageWidgets[prefecture_list[0]].name),
                      ],
                    ),
                  ),
                ),
                // 2つ目の県
                Positioned(
                  top: 450.0,
                  left: 250.0 + positionedAnimation.value,
                  width: Prefecture_width,
                  height: Prefecture_hight,
                  child: Transform.rotate(
                    angle: rotateAnimation.value, // <<< 回転のアニメーション変化を適用
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          imageWidgets[prefecture_list[1]].image_path,
                          fit: BoxFit.cover,
                        ),
                        Text(imageWidgets[prefecture_list[1]].name),
                      ],
                    ),
                  ),
                ),
                // 3つ目の県
                Positioned(
                  top: 300.0,
                  left: 50.0 + positionedAnimation.value,
                  width: Prefecture_width,
                  height: Prefecture_hight,
                  child: Transform.rotate(
                    angle: rotateAnimation.value, // <<< 回転のアニメーション変化を適用
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          imageWidgets[prefecture_list[2]].image_path,
                          fit: BoxFit.cover,
                        ),
                        Text(imageWidgets[prefecture_list[2]].name),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: _circle_x!,
                  top: _circle_y!,
                  child: Icon(Icons.circle, size: 50.0),
                ),
              ],
            );
          },
        ),
      );
    } else {
      return MaterialApp(
        home: Get(),
      );
    }
  }
}

List _shuffle(List items) {
  var random = new Random();
  for (var i = items.length - 1; i > 0; i--) {
    var n = random.nextInt(i + 1);
    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }
  return items;
}

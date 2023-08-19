import 'package:flutter/material.dart';
import 'package:flutter_application_2/make_question.dart';
import 'ans.dart';
import 'dart:math';
import 'prefecture.dart';

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
    var num_ans = _shuffle([0, 1, 2]);
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
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Text('問題文'),

              // 1つ目の県
              Positioned(
                top: 100.0,
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
                top: 250.0,
                left: 200.0 + positionedAnimation.value,
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
                top: 500.0,
                left: 100.0 + positionedAnimation.value,
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
            ],
          );
        },
      ),
    );
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

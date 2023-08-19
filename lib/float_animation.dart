import 'package:flutter/material.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Tween<double> positionedTween;
  late Tween<double> rotateTween; // <<< 2つ目のアニメーションのTween
  late Animation<double> rotateAnimation; // <<< 2つ目のアニメーション
  late Animation<double> positionedAnimation;

  var x = 0;
  var y = 0;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    rotateTween = Tween(begin: 0, end: 2 * pi); // <<< 回転のアニメーションの始点と終点を定義
    positionedTween = Tween(begin: 0.0, end: 50.0);
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
      appBar: AppBar(
        title: const Text('Flutter app'),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Stack(
            children: <Widget>[
              Positioned(
                top: 50.0,
                left: 50.0 + positionedAnimation.value,
                width: 100.0,
                height: 100.0,
                child: Transform.rotate(
                  angle: rotateAnimation.value, // <<< 回転のアニメーション変化を適用
                  child: Container(height: 100, width: 100, color: Colors.blue),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.yellow[700],
        child: Icon(
          Icons.bolt,
          color: Colors.black,
        ),
      ),
    );
  }
}

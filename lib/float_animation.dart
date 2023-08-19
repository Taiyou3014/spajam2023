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
  late Tween<Alignment> alignmentTween; // <<< 1つ目のアニメーションのTween 横の動き
  late Tween<double> rotateTween; // <<< 2つ目のアニメーションのTween
  late Animation<Alignment> alignmentAnimation; // <<< １つ目のアニメーション
  late Animation<double> rotateAnimation; // <<< 2つ目のアニメーション

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
    alignmentTween = Tween(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight); // <<< 位置のアニメーションの始点と終点を定義
    rotateTween = Tween(begin: 0, end: 8 * pi); // <<< 回転のアニメーションの始点と終点を定義
    alignmentAnimation = controller.drive(alignmentTween); // <<< 位置のアニメーションを生成
    rotateAnimation = controller.drive(rotateTween); // <<< 回転のアニメーションを生成
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
          return Align(
            alignment: alignmentAnimation.value, // <<< 位置のアニメーション変化を適用
            child: Transform.rotate(
              angle: rotateAnimation.value, // <<< 回転のアニメーション変化を適用
              child: Text('Hello world!'),
            ),
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

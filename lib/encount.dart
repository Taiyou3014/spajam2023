import 'package:flutter/material.dart';
import 'dart:math';

class EncountWidget extends StatefulWidget {
  const EncountWidget({Key? key}) : super(key: key);

  @override
  State<EncountWidget> createState() => _EncountWidgetState();
}

class _EncountWidgetState extends State<EncountWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Tween<double> rotateTween; // <<< 2つ目のアニメーションのTween
  late Animation<double> rotateAnimation; // <<< 2つ目のアニメーション

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    rotateTween = Tween(begin: 0, end: 8 * pi); // <<< 回転のアニメーションの始点と終点を定義
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
          return Stack(
            children: <Widget>[
              Positioned(
                top: 50.0,
                left: 50.0,
                width: 100.0,
                height: 100.0,
                child: Transform.rotate(
                  angle: rotateAnimation.value, // <<< 回転のアニメーション変化を適用
                  child: Container(height: 100, width: 100, color: Colors.blue),
                ),
              ),
              Positioned(
                top: 200.0,
                left: 200.0,
                width: 100.0,
                height: 100.0,
                child: Transform.rotate(
                  angle: rotateAnimation.value, // <<< 回転のアニメーション変化を適用
                  child: Container(height: 100, width: 100, color: Colors.blue),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

void vibrateDevice(){
  Vibration.vibrate(); // デフォルトの振動を実行 duration:1000とかすれば振動の長さを変更可能
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: const Column(
        children: [
          Text('test'),
          ElevatedButton(
            onPressed: vibrateDevice,
            child: Text("Vibrate"),
          )
        ]
      ),
    );
  }
}

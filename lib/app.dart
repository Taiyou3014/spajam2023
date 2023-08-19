import 'package:flutter/material.dart';
import 'package:flutter_application_2/scoop.dart';

<<<<<<< HEAD
import 'get.dart';
import 'home.dart';
import 'favorite.dart';
import 'explore.dart';
import 'kasokudo.dart';
=======
void main() => runApp(const MyApp());
>>>>>>> 550044107527615ac8f6f8e54ccfcdd61e4b78e7

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // key parameter fixed

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return  MaterialApp(home: Get());
=======
    return const MaterialApp(
      home: Title(),
    );
>>>>>>> 550044107527615ac8f6f8e54ccfcdd61e4b78e7
  }
}

//タイトル画面
class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Scoop()),
              );
            },
            child: const Text("Start"),
          ),
        ),
      ),
    );
  }
}
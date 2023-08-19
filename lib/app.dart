import 'package:flutter/material.dart';
import 'package:flutter_application_2/scoop.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // key parameter fixed

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Title(),
    );
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

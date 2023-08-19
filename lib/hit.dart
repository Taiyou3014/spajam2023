import 'package:flutter/material.dart';
import 'ans.dart';

class Hit extends StatefulWidget {
  final String path; // 引数として受け取る
  final String name;

  Hit({required this.path, required this.name});

  @override
  _Hit createState() => _Hit(path: path, name: name);
}

class _Hit extends State<Hit> {
  final String path;
  final String name;

  _Hit({required this.path, required this.name});

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Container(
      color: Color.fromARGB(255, 165, 252, 226),
      child: Expanded(
        child: Column(
          children: [
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MoneyAnimation(flag: false)),
                );
              },
              child: const Text("next"),
            ),
          ],
        ),
      ),
    );
  }
}

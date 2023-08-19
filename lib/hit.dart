import 'package:flutter/material.dart';
import 'ans.dart';

class Hit extends StatefulWidget {
  final String s; // 引数として受け取る
  Hit({required this.s});

  @override
  _Hit createState() => _Hit(s: s);
}

class _Hit extends State<Hit> {
  final String s;

  _Hit({required this.s});

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Container(
      color: Color.fromARGB(255, 165, 252, 226),
      child: Expanded(
        child: Column(
          children: [
            SizedBox(height: _size.height * 0.25),
            Image.asset(s),
            SizedBox(
              width: 200,
              height: 70,
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

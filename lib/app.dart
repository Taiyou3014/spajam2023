import 'package:flutter/material.dart';
import 'package:flutter_application_2/scoop.dart';
import 'package:google_fonts/google_fonts.dart';

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
    var _size = MediaQuery.of(context).size;
    return Container(
      color: Color.fromARGB(255, 165, 252, 226),
      child: Expanded(
        child: Column(
          children: [
            SizedBox(height: _size.height * 0.25),
            Text(
              '地方すくいず',
              style: GoogleFonts.darumadropOne(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 23, 111, 212),
                  decoration: TextDecoration.none),
            ),
            Image.asset('assets/images/icon.png'),
            SizedBox(
              width: 200,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Scoop()),
                  );
                },
                child: const Text("Start", style: TextStyle(fontSize: 30)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

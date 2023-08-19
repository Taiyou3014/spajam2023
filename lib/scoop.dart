import 'package:flutter/material.dart';

// Scoop(掬う) 都道府県を掬う画面
class Scoop extends StatelessWidget {
  const Scoop({Key? key}) : super(key: key);

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scoop")),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/water.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          const Center(
            child: Text("You are now on the next screen"),
          ),
        ],
      ),
    );
  }

}

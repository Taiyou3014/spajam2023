import 'package:flutter/material.dart';

import 'home.dart';
import 'favorite.dart';
import 'explore.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}


class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  static const _screens = [
    HomeScreen(),
    FavoriteScreen(),
    ExploreScreen(),
  ];

  //現在のPageのカウント
  int currentPageIndex = 0;
  
  void _onItemTapped(int index){
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //下のナビゲーションバー
      body: _screens[currentPageIndex], 
      bottomNavigationBar: BottomNavigationBar(
        //labelBehavior: labelBehavior,
        //iconを選択した時の動作
        selectedIconTheme: const IconThemeData(size: 30, color: Colors.black),
        //iconを選択していない時の動作
        unselectedIconTheme: const IconThemeData(size: 25, color: Color.fromARGB(255, 186, 187, 193)),
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        currentIndex: currentPageIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
           //selectedIcon: Icon(Icons.explore),
            icon: Icon(Icons.explore),
            label: 'Search',
          ),
        ],
      ),  
    );
  }
}
